module Divvy
  module Deployment
    
    def deploy(&block)
      self.instance_eval &block
    end
    
    def server(policy, host)
      Plan.instance.add_server(policy, host)
    end
  end
end