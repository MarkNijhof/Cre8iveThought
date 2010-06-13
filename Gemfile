source :rubygems

# Project requirements
gem 'rake'
gem 'rack-flash'
gem 'thin' # or mongrel

# Component requirements
gem 'haml'
gem 'compass'

# Test requirements
if RUBY_PLATFORM =~ /darwin/
  group :test do
    gem 'autotest'
    gem 'autotest-growl'
    gem 'autotest-fsevent'
    gem 'redgreen'

    gem 'mocha'
    gem 'rspec', :require => "spec"
    gem 'capybara'
    gem 'cucumber'
    gem 'cucumber-rails'
    gem 'rack-test', :require => 'rack/test'
  end
end

# Padrino
gem 'padrino', "0.9.10"
