ENV["TEST"] = "1"
# Ensures aws api never called. Fixture home folder does not contain ~/.aws/credentails
ENV['HOME'] = "spec/fixtures/home"

require "byebug"
require "fileutils"
require 'database_cleaner'
require 'faker'
require 'factory_bot'

require_relative '../app.rb'

# Comment out if the project is using database
#connect_database

module Helpers
  def payload(name)
    JSON.load(IO.read("spec/fixtures/payloads/#{name}.json"))
  end
end

RSpec.configure do |c|
  c.include Helpers
  c.include FactoryBot::Syntax::Methods

  c.before(:suite) do
    FactoryBot.find_definitions

    #DatabaseCleaner.strategy = :transaction
    #DatabaseCleaner.clean_with(:truncation)
  end

  c.around(:each) do |example|
    #DatabaseCleaner.cleaning do
    #  example.run
    #end
  end
end
