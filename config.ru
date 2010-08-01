
require 'toto'
require ::File.dirname(__FILE__) + '/config/boot.rb'

# Rack config
use Rack::Static, :urls => ['/css', '/js', '/images', '/favicon.ico'], :root => 'public'
use Rack::ShowExceptions
use Rack::CommonLogger

if ENV['RACK_ENV'] == 'development'
  use Rack::ShowExceptions
end

#
# Create and configure a toto instance
#

Toto::Paths = {
    :templates => "blog/templates",
    :pages => "blog/templates/pages",
    :articles => "blog/articles"
}

toto = Toto::Server.new do
  #
  # Add your settings here
  # set [:setting], [value]
  # 
  
  
  set :author,    "Mark Nijhof"
  set :title,     "Cre8ive Thought - Mark Nijhof"
  set :prefix,    "blog"
  set :root,      "blog"
  if ENV['RACK_ENV'] != 'production'
    set :url, "http://localhost:3000/blog/index"
  else
    set :url, "http://cre8ivethought.com/blog/index"
  end
  # set :date,      lambda {|now| now.strftime("%d/%m/%Y") }  # date format for articles
  # set :markdown,  :smart                                    # use markdown + smart-mode
  set :disqus,    "cre8ivethought"
  # set :summary,   :max => 150, :delim => /~/                # length of article summary and delimiter
  # set :ext,       'txt'                                     # file extension for articles
  # set :cache,      28800                                    # cache duration, in seconds
  set :date, lambda {|now| now.strftime("%B #{now.day.ordinal} %Y") }
end

app = Rack::Builder.new do
	use Rack::CommonLogger

	map '/blog' do
		run toto
	end

	map '/' do
    run Padrino.application
	end
end.to_app

run app


