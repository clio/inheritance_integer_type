require 'support/active_record'
require 'inheritance_integer_type'
require 'support/base'
require 'support/left_child'
require 'support/right_child'
require 'support/deep_child'
require 'support/other'
require 'support/belongs_to'

RSpec.configure do |config|
  config.before(:suite) do
    ActiveRecord::MigrationContext.new("#{File.dirname(__FILE__)}/support/migrations").migrate
  end

  # No need to return the run the down migration after the test
  # but useful while in development
  # config.after(:suite) do
  #   ActiveRecord::Migrator.down "#{File.dirname(__FILE__)}/support/migrations"
  # end

  config.around do |example|
    ActiveRecord::Base.transaction do
      example.run
      raise ActiveRecord::Rollback
    end
  end

end
