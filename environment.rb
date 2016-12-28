require 'sinatra'
require 'bcrypt'
require 'bundler'

Bundler.require :default

class Skellington < Sinatra::Base

  # construct default :public_folder and :views
  set :root, File.dirname(__FILE__)

  configure :development do
    require 'sinatra/reloader'
    register Sinatra::Reloader
    @db_url = "postgres://#{ENV['USER']}@127.0.0.1/skellington_development"
    Sequel.connect @db_url
  end

  configure :production do
    @db_url = ENV['DATABASE_URL']
    Sequel.connect @db_url
  end

  configure :test do
    `createdb skellington_test`
    Bundler.require :test
    @db_url = "postgres://#{ENV['USER']}@127.0.0.1/skellington_test"
    @db = Sequel.connect @db_url
    # run migrations in test config block instead of in spec_helper because we
    # need to be able to access @db_url which is not initialized yet in
    # spec_helper :\
    Sequel.extension :migration
    Sequel::Migrator.run(@db, File.join(File.expand_path(File.dirname(__FILE__)), 'db', 'migrate'))
  end

  # must be loaded after Sequel.connect
  require './models.rb'
end
