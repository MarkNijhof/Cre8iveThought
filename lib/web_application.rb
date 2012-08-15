
class WebApplication < Sinatra::Base
    
  configure do
    set :public, './public'
    set :haml, :format => :html5
    $host = "http://cre8ivethought.com"
  end

  $blog_dorsey = Dorsey::Server.new do
    set :article_path, './blog/articles'
    set :article_prefix, "blog"
    set :host, $host
    set :disqus, "cre8ivethought"
    set :date, lambda {|now| now.strftime("%B #{now.day.ordinal} %Y") }
  end
  
  get "/blog/index.xml" do
    content_type :"application/atom+xml"
    $show_stats = false
    $header_for = 'blog'
    rss_updated = $blog_dorsey.articles.first.updated_as_date 
    articles    = $blog_dorsey.articles.select{ |item| item[:published] }
    haml(:'rss', :layout=>false, :locals => { :blog_title => "Cre8ive Thought", :rss_updated => rss_updated, :blog_url => "#{$host}blog/index", :rss_url => "#{$host}blog/index.xml", :articles => articles })
  end

  get /^\/blog(\/.*?)(,start\:\d+)?(,end\:\d+)?(,filter_by\:.*)?$/ do |url, start_index, end_index, filter_by|
    
    url         = url == '/'       ? '' : url
    start_index = start_index.nil? ? 0  : start_index.gsub!(/,start\:/, "").to_i
    end_index   = end_index.nil?   ? -1 : end_index.gsub!(/,end\:/, "").to_i - 1
    filter_by   = filter_by.nil?   ? '' : filter_by.gsub!(/,filter_by\:/, "")

    # return "#{url} - #{start_index} - #{end_index} - #{filter_by}"

    articles    = $blog_dorsey.get_by_slug url
    
    articles    = articles.select{ |item| item[:published] }  if articles.count > 1
    
    articles    = articles.each { |post| post[:keywords] = post[:keywords].nil? ? {} : post[:keywords].split(',').to_json }
    
    return [].to_json if articles.count < start_index
    
    articles    = articles[start_index..end_index]
        
    articles    = articles.map { |post| post.reject { |key, value| !filter_by.split(',').include? key.to_s }} if not filter_by == ''

    return articles.to_json if params[:callback].nil? || params[:callback] == ''
    
    return "#{params[:callback]}(#{articles.to_json})"
  end
  
end
