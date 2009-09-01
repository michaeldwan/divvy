Dir["#{File.dirname(__FILE__)}/packages/**/*.rb"].each { |r| require r }

Divvy.package :web do
  apply do
    set_rails_env('production')
  end
  requires :build_essential, :ruby, :ruby_gems, :mysql_ruby_driver, :git
end

Divvy.provision 'your-server.example.com', :web, :user => 'root', :password => 'password'