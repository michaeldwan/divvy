module Divvy
  module Plugins
    module RubyGems
      def ruby_gem(gem_name, options = {})
        options = {
          :no_doc => true,
        }.merge(options)
        
        cmd = "gem install #{gem_name}"
        cmd << " --version '#{options[:version]}'" if options[:version]
        cmd << " --source #{options[:source]}" if options[:source]
        cmd << " --install-dir #{options[:install_dir]}" if options[:install_dir]
        cmd << " --no-rdoc --no-ri" if options[:no_doc]
        cmd << " -- #{build_flags}" if options[:build_flags]
        run(cmd)
      end
    end
  end
end

register_plugin(Divvy::Plugins::RubyGems)