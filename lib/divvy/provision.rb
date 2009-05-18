module Divvy
  module Provision
    
    def provision(name, &block)
      provision = Provision.new(name, &block)
      
    end
    
    class Provision
      def initialize(name, &block)
        @name = name
        @packages = []
        self.instance_eval &block
      end
      
      attr_reader :name
      
      def requires(*packages)
        @packages << packages
        @packages.flatten!
      end
    end
  end
end