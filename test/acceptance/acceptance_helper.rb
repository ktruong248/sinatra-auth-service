require_relative '../test_helper.rb'
require_relative '../../app.rb'

# include this in every describe block
module AcceptanceHelper
  require "minitest/autorun" # for describe and it methods
  require 'capybara/dsl' # for Capybara
  include Capybara::DSL # for visit method

  Capybara.app = MyApp
end



