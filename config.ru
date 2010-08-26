require 'toto'
require ::File.dirname(__FILE__) + '/config/boot.rb'
require 'rack-rewrite'

# Rack config
use Rack::Static, :urls => ['/css', '/js', '/images', '/favicon.ico'], :root => 'public'
use Rack::ShowExceptions
use Rack::CommonLogger

if ENV['RACK_ENV'] == 'development'
  use Rack::ShowExceptions
end

toto_blog = Toto::Server.new do  

  # Toto::Paths[:templates] = "blog/templates"
  # Toto::Paths[:pages] = "blog/templates/pages"
  # Toto::Paths[:articles] = "blog/articles"

  set :templates, "blog/templates"
  set :pages,     "blog/templates/pages"
  set :articles,  "blog/articles"

  set :author,    "Mark Nijhof"
  set :title,     "Cre8ive Thought - Mark Nijhof"
  set :prefix,    "blog"
  set :root,      "blog"
  if ENV['RACK_ENV'] != 'production'
    set :url,     "http://local.cre8ivethought.com:3000/"
    set :cache,   0
  else
    set :url,     "http://cre8ivethought.com/"
    set :cache,   28800
  end
  set :disqus,    "cre8ivethought"
  set :date,      lambda {|now| now.strftime("%B #{now.day.ordinal} %Y") }
end

toto_book = Toto::Server.new do  
  set :templates, "the_software_craftsman/templates"
  set :pages,     "the_software_craftsman/templates/pages"
  set :articles,  "the_software_craftsman/articles"

  set :author,    "Mark Nijhof"
  set :title,     "The Software Craftsman - Mark Nijhof"
  set :prefix,    "the_software_craftsman"
  set :root,      "the_software_craftsman"
  if ENV['RACK_ENV'] != 'production'
    set :url,     "http://local.cre8ivethought.com:3000/"
    set :cache,   0
  else
    set :url,     "http://cre8ivethought.com/"
    set :cache,   28800
  end
  set :disqus,    "cre8ivethought"
  set :date,      lambda {|now| now.strftime("%B #{now.day.ordinal} %Y") }
end

app = Rack::Builder.new do
  use Rack::CommonLogger

  map '/blog' do
    run toto_blog
  end

  map '/the_software_craftsman' do
    run toto_book
  end

  map '/' do
    run Padrino.application
  end
end.to_app

run app


