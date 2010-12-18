
class WebApplication < Sinatra::Base
  
  configure do
    set :public, './public'
    set :haml, :format => :html5
  end

  $blog_dorsey = Dorsey::Server.new do
    set :article_path, './blog/articles'
    set :article_prefix, "blog"
    if ENV['RACK_ENV'] != 'production'
      set :host, "http://local.cre8ivethought.com:3000/"
    else
      set :host, "http://cre8ivethought.com/"
    end
    set :disqus, "cre8ivethought"
    set :date, lambda {|now| now.strftime("%B #{now.day.ordinal} %Y") }
  end

  $book_dorsey = Dorsey::Server.new do
    set :article_path, './book/articles'
    set :article_prefix, "the_software_craftsman"
    if ENV['RACK_ENV'] != 'production'
      set :host, "http://local.cre8ivethought.com:3000/"
    else
      set :host, "http://cre8ivethought.com/"
    end
    set :date, lambda {|now| now.strftime("%B #{now.day.ordinal} %Y") }
  end
  
  get '/' do
    File.read(File.join('public', 'index.html'))
  end
 
  ["/blog/?", "/blog/index/?"].each do |route|
    get route do
      $header_for = 'blog'
      haml(:'blog/index', :locals => { :title => "Cre8ive Thought", :articles => $blog_dorsey.articles})
    end
  end

  get "/blog/index.xml" do
    content_type :"application/atom+xml"
    $header_for = 'blog'
    rss_updated = $blog_dorsey.articles.first.updated_as_date 
    haml(:'rss', :layout=>false, :locals => { :blog_title => "Cre8ive Thought", :rss_updated => rss_updated, :blog_url => "#{$blog_dorsey.config[:host]}blog/index", :rss_url => "#{$blog_dorsey.config[:host]}blog/index.xml", :articles => $blog_dorsey.articles.select{ |item| item[:published] }})
  end

  get '/blog/*' do
    $header_for = 'blog'
    articles = $blog_dorsey.get_by_slug params[:splat][0]

    return haml(:'blog/article', :locals => { :title => "Cre8ive Thought - #{articles[0].title}", :post => articles[0]} ) if articles.count == 1

    return haml(:'blog/archive', :locals => { :title => "Cre8ive Thought - #{params[:splat][0]}", :posts => articles, :slug => params[:splat][0] } ) if articles.count > 1

    haml(:'404', :locals => { :title => "Cre8ive Thought - Not Found", :slug => params[:splat][0] } )
  end
  
  ["/the_software_craftsman/?", "/the_software_craftsman/index/?"].each do |route|
    get route do
      $header_for = 'book'
      haml(:'book/index', :locals => { :title => "The Software Craftsman", :articles => $book_dorsey.articles})
    end
  end

  get '/the_software_craftsman/*' do
    $header_for = 'book'
    articles = $book_dorsey.get_by_slug params[:splat][0]

    return haml(:'book/article', :locals => { :title => "The Software Craftsman - #{articles[0].title}", :post => articles[0]} ) if articles.count == 1

    return haml(:'book/archive', :locals => { :title => "The Software Craftsman - #{params[:splat][0]}", :posts => articles, :slug => params[:splat][0] } ) if articles.count > 1

    haml(:'404', :locals => { :title => "Cre8ive Thought - Not Found", :slug => params[:splat][0] } )
  end
  
end
