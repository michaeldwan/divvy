require 'net/ssh'
require 'net/scp'

module Divvy
  class Server
    def initialize(host, options = {})
      @host = host
      @options = options
    end

    attr_reader :host, :options
    
    def remote_command(command, options = {})
      options = {
        :verbose => Divvy::OPTIONS.verbose, 
        :raise_on_exit_code => true,
        :raise_errors => true
      }.merge(options)
      puts command if options[:verbose]
      response_data = ''
      begin
        Net::SSH.start(host, self.options[:user], :password => self.options[:password]) do |ssh|
          ssh.open_channel do |channel|
            channel.exec(command) do |ch, success|
              raise "FAILED: couldn't execute command (ssh.channel.exec failure)" unless success

              channel.on_data do |ch, data|  # stdout
                print data if options[:verbose]
                STDOUT.flush
                response_data << data
              end

              channel.on_extended_data do |ch, type, data|
                next unless type == 1  # only handle stderr
                $stderr.print data
              end

              channel.on_request("exit-status") do |ch, data|
                exit_code = data.read_long
                raise NonZeroExitCode.new(command, exit_code) if exit_code > 0 && options[:raise_on_exit_code]
              end

              channel.on_request("exit-signal") do |ch, data|
                puts "SIGNAL: #{data.read_long}"
              end
            end
          end
          ssh.loop
        end
      rescue Exception => err
        return false unless options[:raise_errors]
        raise
      end
      response_data
    end

    def scp(source, target, options = {})
      Net::SCP.start(host, self.options[:user], :password => self.options[:password]) do |scp|
        scp.upload! source, target do |ch, name, sent, total|
          puts "#{name}: #{sent}/#{total}"
        end
      end
    end
  end

  class NonZeroExitCode < Exception
    def initialize(command, exit_code)
      super("Non-zero exit code: #{exit_code} for #{command}")
      @command = command
      @exit_code = exit_code
    end
    
    attr_accessor :command, :exit_code
  end
end
