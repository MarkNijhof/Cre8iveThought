
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
  
  get '/' do
    $show_stats = false
    File.read(File.join('public', 'index.html'))
  end
 
  ["/blog/?", "/blog/index/?"].each do |route|
    get route do
      $show_stats = false
      $header_for = 'blog'
      haml(:'blog/index', :locals => { :title => "Cre8ive Thought", :articles => $blog_dorsey.articles})
    end
  end

  get "/blog/index.xml" do
    content_type :"application/atom+xml"
    $show_stats = false
    $header_for = 'blog'
    rss_updated = $blog_dorsey.articles.first.updated_as_date 
    haml(:'rss', :layout=>false, :locals => { :blog_title => "Cre8ive Thought", :rss_updated => rss_updated, :blog_url => "#{$blog_dorsey.config[:host]}blog/index", :rss_url => "#{$blog_dorsey.config[:host]}blog/index.xml", :articles => $blog_dorsey.articles.select{ |item| item[:published] }})
  end

  get '/blog/*.json/*/*/*' do
    articles = ($blog_dorsey.get_by_slug params[:splat][0])[params[:splat][1].to_i...params[:splat][2].to_i]
    
    return articles.map { |post| post.reject! { |key, value| !params[:splat][3].split(',').include? key.to_s }}.to_json
  end

  get '/blog/*.json/*/*' do
    articles = ($blog_dorsey.get_by_slug params[:splat][0])[params[:splat][1].to_i...params[:splat][2].to_i]
    return articles.to_json
  end

  get '/blog/*.json/*' do
    articles = ($blog_dorsey.get_by_slug params[:splat][0])
    
    return articles.map { |post| post.reject! { |key, value| !params[:splat][1].split(',').include? key.to_s }}.to_json
  end

  get '/blog/*.json' do
    articles = $blog_dorsey.get_by_slug params[:splat][0]
    return articles.to_json
  end

  get '/blog/*' do
    $header_for = 'blog'
    $show_stats = false
    articles = $blog_dorsey.get_by_slug params[:splat][0]

    $show_stats = true
    return haml(:'blog/article', :locals => { :title => "Cre8ive Thought - #{articles[0].title}", :post => articles[0]} ) if articles.count == 1

    $show_stats = false
    return haml(:'blog/archive', :locals => { :title => "Cre8ive Thought - #{params[:splat][0]}", :posts => articles, :slug => params[:splat][0] } ) if articles.count > 1

    haml(:'404', :locals => { :title => "Cre8ive Thought - Not Found", :slug => params[:splat][0] } )
  end
  
end
