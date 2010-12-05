
task :sass do
  sh "bundle exec compass compile public -e production --force"
end

task :run => [:set_development_environment] do
  sh "shotgun config.ru -o local.cre8ivethought.com -p 3000 -s thin -E development" 
  # sh "thin start -R config.ru -a local.cre8ivethought.com"
  # sh "rackup -o local.cre8ivethought.com -p 3000"
end  

task :test => [:set_test_environment] do
  sh "bundle exec autotest"
end

task :set_heroku_production_environment do
  sh "heroku config:add RACK_ENV=production"
  sh "heroku config:add BUNDLE_WITHOUT='test development'"
end

task :set_heroku_development_environment do
  sh "heroku config:add RACK_ENV=production"
  sh "heroku config:add BUNDLE_WITHOUT='test development'"
end

task :set_development_environment do
  ENV['RACK_ENV'] = "production"
end

task :set_test_environment do
  ENV['AUTOFEATURE'] = 'true' 
  ENV['RSPEC'] = 'true'
  ENV['RACK_ENV'] = "production"
end

require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new do |t|
#  t.rspec_opts = ["-c", "-f progress", "-r ./spec/spec_helper.rb"]
#  t.pattern = 'spec/**/*_spec.rb'
end

