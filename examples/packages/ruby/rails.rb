Divvy.package :rails do
  requires :ruby_gems

  verify do
    has_executable 'rails'
  end
  
  apply do
    ruby_gem 'rails'
  end
end