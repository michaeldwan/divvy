package :mysql do
  requires :foo
  
  # verify do
  #   
  # end
end

package :foo do
  
end

provision :web do
  requires :mysql
end


deploy do
  server :web, '67.23.25.222', :user => 'root', :password => 'web01lEXKMd'
end
