require 'rubygems'
# require 'activesupport'

Dir["#{File.dirname(__FILE__)}/divvy/*.rb"].each { |f| require f}

class Object
  include Divvy::Script
end

register_verifier(Divvy::Verifiers)

Dir["#{File.dirname(__FILE__)}/divvy/plugins/*"].each { |f| require f }