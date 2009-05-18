module Divvy
  class Script
    def self.divvy(script, filename = '__SCRIPT__')
      thingy = new
      thingy.instance_eval script, filename
      Plan.instance.go
    end
  end
end