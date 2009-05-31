Divvy.package :mysql do
  verify do
    has_executable 'mysql'
  end

  apply do
    apt %q(mysql-server mysql-client libmysqlclient15-dev)
  end
end

Divvy.package :mysql_ruby_driver do
  requires :mysql, :ruby, :ruby_gems
  verify do
    ruby_can_load 'mysql'
  end

  apply do
    ruby_gem 'mysql'
  end
end
