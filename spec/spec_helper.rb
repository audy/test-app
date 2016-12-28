require 'bundler'

Bundler.require(:default, :test)

Sinatra::Base.set :environment, :test
Sinatra::Base.set :run, false
Sinatra::Base.set :logging, false
Sinatra::Base.set :raise_errors, true

require File.join(File.dirname(__FILE__), '..', 'application')

Sequel.extension :migration

RSpec.configure do |config|

  def app
    Skellington
  end

  config.before(:each) {}

  config.include Rack::Test::Methods
end
