require 'rubygems'
require 'bundler/setup'
require 'bierdopje'

RSpec.configure do |config|
  config.before :each do
    api_config = YAML.load_file(File.dirname(__FILE__) + '/api.yml')
    Bierdopje::Base.api_key = api_config['key']
  end
end
