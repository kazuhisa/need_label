$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rails'
require 'rspec'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}
require File.join(File.dirname(__FILE__), 'fake_app')

require 'capybara/rails'
require 'rspec/rails'

RSpec.configure do |config|
  config.mock_with :rr
  config.before :all do
    CreateAllTables.up unless ActiveRecord::Base.connection.table_exists? 'users'
    CreateAllTables.up unless ActiveRecord::Base.connection.table_exists? 'user_with_procs'
  end
end
