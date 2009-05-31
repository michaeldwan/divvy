module Divvy
  class DuplicatePackageError < RuntimeError
    
    attr_accessor :package
    
    def initialize(package)
      super("The package #{package} has already been registered")
      @package = package
    end
  end
end