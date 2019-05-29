require 'active_record'
Dir["#{File.dirname(__FILE__)}/migrations/*.rb"].each {|f| require f}

config = {
  :adapter => "sqlite3",
  :database => ":memory:",
}
ActiveRecord::Base.establish_connection(config)
