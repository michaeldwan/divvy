module Divvy
  class Package
    
    def initialize(name, options = {}, &block)
      @name = name
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
      @dependencies.map { |key| Divvy::Script.get_package(key) }        
    end

    def apply(&block)
      @apply_block = block
    end
    
    def verify(description = '', &block)
      @verifications << Verification.new(self, description, &block)
    end
  end
end
