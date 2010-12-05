#require 'rubygems'
#require 'sinatra'
#require 'haml'
#
#require 'rspec'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require 'rack/test'
require './config/boot'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
# Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  config.filter_run :focus => true
  config.run_all_when_everything_filtered = true
  config.filter_run_excluding :slow => true
  
  config.formatter = 'documentation'
#  config.options = %w[--color]
#  config.rspec_opts = ["-c", "-f progress", "-r ./spec/spec_helper.rb"]
#  config.pattern = 'spec/**/*_spec.rb'
end