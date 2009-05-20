module Divvy
  module Script
    PACKAGES = {}
    
    def package(name, options = {}, &block)
      package = Package.new(name, options, &block)
      raise 'Duplicate package name' if PACKAGES.key?(package.name)
      PACKAGES[package.name] = package
    end

    def provision(host, package, server_options)
      provision = Provisioner.new(host, package, server_options)
      provision.run
    end
    
    def register_verifier(verifier)
      Divvy::Verification.class_eval { include verifier }
    end

    def register_plugin(plugin)
      Divvy::PackageRunner.class_eval { include plugin }
    end
    
    def get_package(key)
      package = PACKAGES[key]
      raise "Package #{key} not found!" unless package
      package
    end
  end
end
