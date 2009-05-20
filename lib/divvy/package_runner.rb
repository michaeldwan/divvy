module Divvy
  class PackageRunner
    def initialize(server, package)
      @server, @package = server, package
    end
    
    attr_reader :server, :package
    
    def run(command, options = {})
      server.remote_command(command, options)
    end
    
    def scp(source, destination, options = {})
      server.scp(source, destination, options)
    end
    
    def process
      puts "==> Processing #{package.name}"
      
      unless package.verifications.empty?
        begin
          process_verifications(true)
          puts " --> #{package.name} already installed package: #{server.host}"
          return
        rescue Divvy::VerificationFailed => e
          # Yaay package not installed yet
        end
      end
      
      self.instance_eval(&package.apply_block) unless package.apply_block.nil?
          
      process_verifications
    end

    private
      def process_verifications(pre = false)
        return if package.verifications.empty?
        
        if pre
          puts " --> Checking if #{package.name} is already installed for server: #{server.host}"
        else
          puts " --> Verifying #{package.name} was properly installed for server: #{server.host}"
        end

        package.verifications.each do |v|
          v.verify(server)
        end
        
      end
  end
end