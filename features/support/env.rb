PADRINO_ENV = 'test' unless defined?(PADRINO_ENV)
require File.expand_path(File.dirname(__FILE__) + "/../../config/boot")

require 'capybara/cucumber'
#require 'spec/expectations'
begin require 'rspec/expectations'; rescue LoadError; require 'spec/expectations'; end
require 'mongoid'

##
# You can handle all padrino applications using instead:
# Capybara.app_host = 'local.17jobs.com:3000'
# Capybara.run_server = false

class Capybara::Server
  def host
    "local.17jobs.com"
  end
end

Capybara.default_wait_time = 5

Capybara.app = Padrino.application
# Capybara.app = ItJobsCom.tap { |app|  }

Before do
  # Mongoid.master.collections.each(&:drop)
  Mongoid.master.collections.select { |c| !c.name.match /^system\./ }.each(&:drop)  
end