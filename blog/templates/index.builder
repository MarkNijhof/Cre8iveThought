
xml.instruct!
xml.feed "xmlns" => "http://www.w3.org/2005/Atom" do
  xml.title @config[:title]
  xml.id @config[:url]
  xml.updated articles.first[:date].iso8601 unless articles.empty?
  xml.author { xml.name @config[:author] }

  articles.select{|item| !item[:skip] }.reverse[0..-1].each do |article|
    xml.entry do
      xml.title article.title
      xml.link "rel" => "alternate", "href" => article.url
      xml.id article.url
      xml.published article[:date].iso8601
      xml.updated article[:date].iso8601
      xml.author { xml.name @config[:author] }
      xml.summary article.summary, "type" => "html"

      no_script_html = ""
      if /<script src=\"http:\/\/gist.github.com/.match(article.body)
        no_script_html = "<noscript><p style='margin-left: 10px; margin-right: 10px;'><i>The RSS reader you are using doesn't support JavaScript; because of this you will not see the embedded code gists. Consider opening the <a href='#{article.url}'>post</a> in your browser instead.</i></p></noscript>"
      end

      xml.content no_script_html + article.body, "type" => "html"
    end
  end
end

