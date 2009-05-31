Divvy.package :sqlite3 do
  verify do
    has_executable 'sqlite3'
  end

  apply do
    apt 'sqlite3'
  end  
end

Divvy.package :sqlite3_ruby do
  requires :sqlite3
  
  verify do
    ruby_can_load 'sqlite3'
  end
  
  apply do
    apt 'libsqlite3-dev libsqlite3-ruby1.8'
  end
end