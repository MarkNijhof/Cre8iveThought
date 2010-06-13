
task :run_ie => [:set_development_environment] do
  sh "padrino start -h mbpro.local"
end

task :run => [:set_development_environment] do
  sh "padrino start -h local.cre8ivethought.com"
end

task :test => [:set_test_environment] do
  sh "bundle exec autotest"
  # sh "/bin/sh lib/tools/nt AUTOFEATURE=true RSPEC=true autotest"
  # /bin/sh lib/tools/nt 
end

task :set_heroku_production_environment do
  sh "heroku config:add RACK_ENV=production"
end

task :set_heroku_development_environment do
  sh "heroku config:add RACK_ENV=production"
end

task :set_development_environment do
  ENV['RACK_ENV'] = "production"
end

task :set_test_environment do
  ENV['AUTOFEATURE'] = 'true' 
  ENV['RSPEC'] = 'true'
  ENV['RACK_ENV'] = "production"
end
