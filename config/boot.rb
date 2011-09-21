require 'rubygems'
require 'bundler'

SINATRA_ENV  = ENV["RACK_ENV"] ||= "development" unless defined? SINATRA_ENV
SINATRA_ROOT = File.dirname(__FILE__) + '/..' unless defined? SINATRA_ROOT

begin
  # Require the preresolved locked set of gems.
  require File.expand_path('../../.bundle/environment', __FILE__)
rescue LoadError
  # Fallback on doing the resolve at runtime.
  require 'rubygems'
  require 'bundler'
  Bundler.setup()
end

Bundler.require(:default, SINATRA_ENV.to_sym)
puts "=> Located Gemfile for #{SINATRA_ENV}"

require 'rack-rewrite'
require 'haml'
require 'json'
require './lib/dorsey'
require './lib/web_application'
