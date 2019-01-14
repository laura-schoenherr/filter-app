ENV["RAILS_ENV"] ||= 'test'

require 'pludoni_rspec'
PludoniRspec.run

require 'sidekiq/testing'
RSpec.configure do |config|
  config.before(:each) do
    Sidekiq::Testing.fake!
  end
end
