module Divvy
  class Verification

    attr_accessor :package, :description, :commands #:nodoc:
    
    def initialize(package, description = '', &block) #:nodoc:
      raise 'Verify requires a block.' unless block
      
      @package = package
      @description = description.empty? ? package.name : description
      @commands = []
      
      self.instance_eval(&block)
    end
    
    def verify(server)
      @commands.each do |command|
        begin
          server.remote_command(command)
        rescue Divvy::NonZeroExitCode => ex  
          raise Divvy::VerificationFailed.new(@package, description)
        end
      end
    end
  end
  
  class VerificationFailed < Exception #:nodoc:
    attr_accessor :package, :description
    
    def initialize(package, description)
      super("Verifying #{package.name}#{description} failed.")
      
      @package = package
      @description = description
    end
  end
end
