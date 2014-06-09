require 'active_record'
Dir["#{File.dirname(__FILE__)}/migrations/*.rb"].each {|f| require f}

config = {
  :adapter => "mysql",
  :host => "localhost",
  :database => "inheritance_integer_type_test",
  :username => "iit",
  :password => ""
}
ActiveRecord::Base.establish_connection(config)
