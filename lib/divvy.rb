Dir["#{File.dirname(__FILE__)}/divvy/*.rb"].each { |f| require f}
# require "#{File.dirname(__FILE__)}/divvy/package"
# require "#{File.dirname(__FILE__)}/divvy/policy"
# require "#{File.dirname(__FILE__)}/divvy/script"

class Object
  include Divvy::Package, Divvy::Provision, Divvy::Deployment
end