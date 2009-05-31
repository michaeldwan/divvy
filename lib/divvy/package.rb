module Divvy
  class Package
    
    def initialize(name, options = {}, &block)
      # raise ArgumentError.new('Name is required') unless name
      @name = name.to_sym
      @options = options
      @dependencies = []
      @verifications = []
      self.instance_eval(&block)
    end

    attr_reader :name, :options, :verifications, :apply_block

    def requires(*packages)
      @dependencies << packages
      @dependencies.flatten!
    end
    
    def dependencies
      @dependencies.each { |package| raise "Package #{package} not found!" unless Divvy.packages.key?(package) }
      @dependencies.map { |key| Divvy.packages[key] }
    end

    def apply(&block)
      @apply_block = block
    end
    
    def verify(description = '', &block)
      @verifications << Verification.new(self, description, &block)
    end
  end
end
