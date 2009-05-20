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
      begin
        Net::SSH.start(host, self.options[:user], :password => self.options[:password]) do |ssh|
          ssh.open_channel do |channel|
            channel.exec(command) do |ch, success|
              raise "FAILED: couldn't execute command (ssh.channel.exec failure)" unless success

              channel.on_data do |ch, data|  # stdout
                print data
              end

              channel.on_extended_data do |ch, type, data|
                next unless type == 1  # only handle stderr
                $stderr.print data
              end

              channel.on_request("exit-status") do |ch, data|
                exit_code = data.read_long
                raise "ERROR: exit code #{exit_code}" if exit_code > 0
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
      true
    end

    def scp(source, target, options = {})
      Net::SCP.start(host, self.options[:user], :password => self.options[:password]) do |scp|
        scp.upload! source, target do |ch, name, sent, total|
          puts "#{name}: #{sent}/#{total}"
        end
      end
    end
  end
end
