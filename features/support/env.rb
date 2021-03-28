require 'cucumber'
require 'factory_bot'
require 'rspec'
require 'logger'
require 'pry'
require 'rspec/expectations'

require_relative '../../config/boot'

require_relative 'config'
SETTINGS ||= Config.new.settings

# factory bot settings
World(FactoryBot::Syntax::Methods)
FactoryBot.find_definitions

# adding RSpec methods to Cucumber World namespace
World(RSpec::Expectations)

# initializing logger
LOG = Logger.new(STDOUT)

# including module with common methods
require_relative 'common_methods'
include CommonMethods

# including Warehous
require_relative 'warehouse'
include Warehouse

[UserAPI, PetAPI, StoreAPI].each { |api| api.initialize }

