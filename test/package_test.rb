require 'test_helper'

class PackageTest < Test::Unit::TestCase
  
  context 'initialize' do
    should 'set name to name accessor' do
      package = Divvy::Package.new :michael do
      end
      assert_equal :michael, package.name
    end
    
    should 'convert name strings into symbols' do
      package = Divvy::Package.new 'michael' do
      end
      assert_equal :michael, package.name
    end
        
    should 'set dependencies to an empty array' do
      package = Divvy::Package.new :name do
      end
      assert_equal [], package.dependencies
    end

    should 'set verifications to an empty array' do
      package = Divvy::Package.new :name do
      end
      assert_equal [], package.verifications
    end
    
    should 'assign options to options accessor' do
      options = { :peanut => 'butter jelly time' }
      package = Divvy::Package.new :name, options do
      end
      assert_equal options, package.options
    end

    should 'assign options an empty hash if no options present' do
      package = Divvy::Package.new :name do
      end
      assert_equal Hash.new, package.options
    end
    
  end
  
end