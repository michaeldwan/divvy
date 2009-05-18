module Divvy
  module Package
    PACKAGES = []
    def package(name, options = {}, &block)
      package = Package.new(name, options, &block)
      Plan.instance.add_package(package)
    end

    class Package
      def initialize(name, options = {}, &block)
        @name = name
        @options = options
        @dependencies = []
        self.instance_eval &block
      end

      attr_reader :name, :options

      def requires(*packages)
        @dependencies << packages
        @dependencies.flatten!
      end
      
      def dependencies
        @dependencies.map { |key| Plan.instance.packages[key] }
      end
      
      def to_s
        name
      end
    end
  end
end

