
module Dorsey
  class Articles < Array

    def initialize config
      @config = config
      load_articles article_files @config[:article_path]
    end
    
    protected
    
    def article_files articles_path
      Dir["#{articles_path}/*.txt"].sort_by {|entry| File.basename(entry) }
    end
    
    def load_articles article_files
      article_files.each { |file| self << Article.new(file, @config) }
    end

  end
end
