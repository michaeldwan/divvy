module Divvy
  module Deployment
    
    def deploy(&block)
      self.instance_eval &block
    end
    
    def server(provision, host, options = {})
      server = Server.new(provision, host, options)
      Plan.instance.add_server(server)
    end
  end
end