module Divvy
  module Plugins
    module Rails
      def set_rails_env(env, file = '~/.profile')
        run("grep -q \"export RAILS_ENV=production\" #{file} || echo \"export RAILS_ENV=#{env}\" >> #{file}")
      end
    end
  end
end

Divvy.register_plugin(Divvy::Plugins::Rails)