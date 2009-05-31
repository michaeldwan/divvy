require 'test_helper'

class DivvyTest < Test::Unit::TestCase
  
  context 'internal_init' do
    should 'flag itself as initialized' do
      Divvy.init
      assert Divvy.initialized
    end
    
    should 'setup empty packages' do
      Divvy.init
      assert_equal Hash.new, Divvy.packages
    end
  end
  
  context 'run' do
    should 'call initialize' do
      Divvy.expects(:init)
      Divvy.run('')
    end
    
    should 'eval the script on Object' do
      Object.any_instance.expects(:instance_eval).with('foobar', 'michael.rb')
      Divvy.run('foobar', 'michael.rb')
    end
    
    should 'set the filename to __SCRIPT__ if no filename specified' do
      Object.any_instance.expects(:instance_eval).with('foobar', '__SCRIPT__')
      Divvy.run('foobar')
    end
  end
  
  context 'packages' do
    should 'add a package to the internal packages' do
      code = <<-EOF
        Divvy.package :foobar do
        end
      EOF
      
      Divvy.run(code)

      assert_equal 1, Divvy.packages.size
    end
    
    should 'raise DuplicatePackageError when adding duplicate package names' do
      code = <<-EOF
        Divvy.package :foobar do
        end
        Divvy.package :foobar do
        end
      EOF
            
      assert_raises Divvy::DuplicatePackageError do
        Divvy.run(code)
      end
    end
    
  end

end
