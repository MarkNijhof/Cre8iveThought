
module Dorsey
  class Config < Hash
    Defaults = {
      :article_prefix => "",
      :host => "",
      :article_path => "articles",
      :summary_delimiter => /\n/,
      :summary_length => 150,
      :markdown => :smart,
      :url => "",
      :disqus => "",
      :date => lambda {|now| now.strftime("%d/%m/%Y") }
    }

    def initialize obj
      self.update Defaults
      self.update obj
    end

    def set key, val = nil, &blk
      if val.is_a? Hash
        self[key].update val
      else
        self[key] = block_given?? blk : val
      end
    end
  end
end
