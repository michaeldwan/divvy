package :mysql do
  requires :foo
end

package :foo do
  
end

provision :web do
  requires :foo
  requires :mysql
end


deploy do
  server :app, 'app1.example.com'
  server :app, 'app2.example.com'
  server :web, 'web.example.com'
end
