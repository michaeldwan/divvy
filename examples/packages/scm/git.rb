package :git do
  requires :build_essential
  
  verify do
    has_executable 'git'
  end
  
  apply do
    apt 'git-core'
  end
end
