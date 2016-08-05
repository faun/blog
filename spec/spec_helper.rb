require 'rspec'
require 'capybara/rspec'
require 'middleman/rack'

ENV['RACK_ENV'] ||= 'test'

RSpec.configure do |config|
  config.order = 'random'
  config.include Capybara::DSL
  Capybara.asset_host = 'http://localhost:4567'
  config_file = File.expand_path('../../config.ru', __FILE__)
  Capybara.app = Rack::Builder.parse_file(config_file).first
end
