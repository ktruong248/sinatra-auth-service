require 'rspec/autorun'
require 'rubygems'
require 'json'
require 'data_mapper'
require 'sinatra'
require 'sinatra/jsonp'
require 'rack/test'
require 'rspec'

Dir.glob("#{File.dirname(__FILE__)}/../models/*.rb") { |file| require "#{file}"}
Dir.glob("#{File.dirname(__FILE__)}/../routes/*.rb") { |file| require "#{file}"}

RSpec.configure do |config|
  # == Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.mock_with :rspec
end
