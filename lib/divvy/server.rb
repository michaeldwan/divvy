module Divvy
  class Server

    def initialize(provision, host, options = {})
      @provision = provision
      @host = host
      @options = options
    end

    attr_reader :provision, :host, :options
        
  end
end