require 'date'
require 'rack'
require 'rdiscount'

module Dorsey
  class Article < Hash
    Defaults = {
      :publish_date => "",
      :body => "",
      :summary => "",
      :file => "",
      :url => ""
    }

    def initialize article_file, config
      self[:file] = article_file
      self[:disqus] = config[:disqus]
      @config = config
      load_article article_file
    end

    def [] key
      return self[:__slug] || self[:title].slugize if key == :slug
      super
    end
    
    def method_missing m, *args, &blk
      self[m.to_sym] || super
    end

    protected
        
    def markdown text
      if (options = @config[:markdown])
        Markdown.new(text.to_s.strip, *(options.eql?(true) ? [] : options)).to_html
      else
        text.strip
      end
    end

    def get_summary body
      body =~ @config[:summary_delimiter] ? body.split(@config[:summary_delimiter]).first : body
    end

    def load_article article_file
      raw_meta_data, body = File.read(article_file).split(/\n\n/, 2)
      self[:body] = markdown body
      self[:summary] = markdown(get_summary(body))
      self.update abstract_meta_data(article_file, raw_meta_data)
      generate_url
    end
    
    def abstract_meta_data article_file, raw_meta_data
      meta_data = YAML.load(raw_meta_data).inject({}) {|h, (k,v)| h.merge(k.to_sym => v) }
      
      article_file =~ /\/(\d{4}-\d{2}-\d{2})[^\/]*$/ 
      (date = $1)

      meta_data[:date_as_date] = Date.parse(date.gsub('/', '-')) rescue Date.today 
      meta_data[:date] = @config[:date].call meta_data[:date_as_date]
      meta_data[:updated] = meta_data[:updated] ? Date.parse(meta_data[:updated].gsub('/', '-')) : meta_data[:date_as_date]
      meta_data = rename_slug_key meta_data
      meta_data
    end
    
    def rename_slug_key meta_data
      meta_data[:__slug] = meta_data[:slug] if !meta_data[:slug].nil?
      meta_data.delete :slug
      meta_data
    end

    def generate_url 
      url = File.join @config[:host], @config[:article_prefix]
      self[:url] = File.join url, path
    end
    
    def path
      "/#{self[:date_as_date].strftime("%Y/%m/%d/#{self[:slug]}")}/"
    end

  end
end
