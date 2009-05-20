module Divvy
  class Provisioner
    def initialize(host, target_package, server_options)
      @target_package = Divvy::Script::PACKAGES[target_package]
      raise "Package #{target_package} not found!" unless @target_package
      @server = Server.new(host, server_options)
    end
    
    attr_reader :target_package, :server
    
    def run
      install_plan = normalize(target_package)
      puts "Normalized install order: #{install_plan.map { |package| package.name }.join(', ')}"
      install_plan.each do |package|
        PackageRunner.new(server, package).process
      end
    end
    
    private
      # TODO: this does not prevent circular dependencies yet
      def normalize(package)
        packages = []
        package.dependencies.each do |dependent|
          packages << normalize(dependent)
          packages << package
        end
        packages << package
        packages.flatten.uniq
      end
  end
end