Divvy.package :ruby do
  requires :build_essential
  
  verify { has_file '/usr/bin/ruby1.8' }
  verify { has_file '/usr/bin/ri1.8' }
  verify { has_file '/usr/bin/rdoc1.8' }
  verify { has_file '/usr/bin/irb1.8' }

  
  apply do
    apt %q(ruby1.8-dev ruby1.8 ri1.8 rdoc1.8 irb1.8 libreadline-ruby1.8 libruby1.8 libopenssl-ruby)
    run('ln -s /usr/bin/ruby1.8 /usr/bin/ruby')
    run('ln -s /usr/bin/ri1.8 /usr/bin/ri')
    run('ln -s /usr/bin/rdoc1.8 /usr/bin/rdoc')
    run('ln -s /usr/bin/irb1.8 /usr/bin/irb')
  end  
end
