require 'active_record'
Dir["#{File.dirname(__FILE__)}/migrations/*.rb"].each {|f| require f}

config = {
  :adapter => "mysql2",
  :host => "localhost",
  :database => "inheritance_integer_type_test",
  :username => "root",
  :password => "iasEcerdyetvanyet"
}
ActiveRecord::Base.establish_connection(config)
