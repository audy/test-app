require './environment.rb'

desc 'start application console'
task :console do
  require 'irb'
  ARGV.clear
  IRB.start
end

desc 'run specs'
task :spec do
  puts "DATABASE_URL=postgres://#{ENV['USER']}@127.0.0.1/skellington_test rspec"
end

namespace :db do

  desc 'migrate the database'
  task :migrate do
    `bundle exec sequel postgres://localhost/skellington_development --migrate-directory db/migrate`
  end

  desc 'seed the database with information'
  task :seed do
  end
end
