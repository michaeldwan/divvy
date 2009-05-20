module Divvy
  module Plugins
    module Apt
      def apt(*packages)
        packages.flatten!
        
        options = { :dependencies_only => false }
        options.update(packages.pop) if packages.last.is_a?(Hash)
        
        command = [ "DEBCONF_TERSE='yes' DEBIAN_PRIORITY='critical' DEBIAN_FRONTEND=noninteractive" ]
        command << 'apt-get -qyu'
        command << (options[:dependencies_only] ? 'build-dep' : 'install')
        command << packages
        
        run(command.join(' '))
      end      
    end
  end
end

register_plugin(Divvy::Plugins::Apt)
