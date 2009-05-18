require 'singleton'

module Divvy
  class Plan
    include Singleton
    
    def initialize()
      @packages = {}
      @provisions = {}
      @servers = Hash.new{|hash, key| hash[key] = Array.new;}
    end

    attr_reader :packages, :provisions
    
    def add_package(package)
      raise 'Duplicate package name' if @packages.key?(package.name)
      @packages[package.name] = package
    end
    
    def add_provision(provision)
      raise 'Duplicate provision name' if @provisions.key?(provision.name)      
      @provisions[provision.name] = provision
    end
    
    def add_server(provision, host)
      @servers[host] << provision
    end
    
    def go
      puts 'running'
      puts @servers.inspect
    end
    
    private
      def print_package(package, depth = 1)
        padding = ' '
        puts "#{padding * depth}#{package.name}"
        package.dependencies.each do |dependent_package|
          print_package(dependent_package, depth + 1)
        end
      end
  end
end
