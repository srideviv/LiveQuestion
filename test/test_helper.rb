ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

#require 'webrat'

#Webrat.configure do |config|
 # config.mode = :rails
#end


class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
  require "webrat"
  require "webrat/core/matchers"
  Webrat.configure do |config|
    config.mode= :rack
  end

end


