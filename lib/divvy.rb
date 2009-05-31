require 'rubygems'

Dir["#{File.dirname(__FILE__)}/divvy/*.rb"].each { |f| require f}

# class Object
#   include Divvy::Script
# end

module Divvy
  class << self
    # user configurable
    attr_accessor :test,
                       :verbose
                       # :port,
                       # :allow,
                       # :log_buffer_size,
                       # :pid_file_directory,
                       # :log_file,
                       # :log_level,
                       # :use_events
    
    # Internal variables
    attr_accessor :initialized,
                  # :running,
                  :packages
  end
  
  def self.say(message)
    puts message
  end
  
  def self.init
    # exit if divvy is already initialized
    return if self.initialized
    
    # variable init
    self.packages = {}
    
    # # set defaults
    # self.log_buffer_size ||= LOG_BUFFER_SIZE_DEFAULT
    # self.port ||= DRB_PORT_DEFAULT
    # self.allow ||= DRB_ALLOW_DEFAULT
    # self.log_level ||= LOG_LEVEL_DEFAULT
    
    # # log level
    # log_level_map = {:debug => Logger::DEBUG,
    #                  :info => Logger::INFO,
    #                  :warn => Logger::WARN,
    #                  :error => Logger::ERROR,
    #                  :fatal => Logger::FATAL}
    # LOG.level = log_level_map[self.log_level]
    
    # flag as initialized
    self.initialized = true
    
    # not yet running
    # self.running = false
  end
  
  def self.register_verifier(verifier)
    Divvy::Verification.class_eval { include verifier }
  end

  def self.register_plugin(plugin)
    Divvy::PackageRunner.class_eval { include plugin }
  end
  
  def self.package(name, options = {}, &block)
    package = Package.new(name, options, &block)
    raise DuplicatePackageError.new(package.name) if packages.key?(package.name)
    packages[package.name] = package
  end

  def self.provision(host, package, server_options)
    provision = Provisioner.new(host, package, server_options)
    provision.run
  end
  
  def get_package(key)
    package = PACKAGES[key]
    raise "Package #{key} not found!" unless package
    package
  end

  def self.run(script, filename = '__SCRIPT__')
    Divvy.init
    Object.new.instance_eval(script, filename)
  end

end

Divvy.register_verifier(Divvy::Verifiers)

Dir["#{File.dirname(__FILE__)}/divvy/plugins/*"].each { |f| require f }