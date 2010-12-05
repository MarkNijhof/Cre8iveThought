require File.dirname(__FILE__) + '/spec_helper'

describe "Dorsey" do

  require 'dorsey'

  it "will find articles in the specified location" do
    dorsey = Dorsey::Server.new do
      set :article_path, './spec/articles'
    end

    dorsey.articles.count.should == 3
  end

  it "will process the articles in the specified location" do
    dorsey = Dorsey::Server.new do
      set :article_path, './spec/articles'
    end

    dorsey.articles[2].is_a?(Dorsey::Article).should == true
    dorsey.articles[2][:date].should == '01/10/2010'
    dorsey.articles[2][:title].should == 'Test 1 2 3'
    dorsey.articles[2][:author].should == 'Mark Nijhof'
    dorsey.articles[2][:published].should == true
  end

  it "will use the file date instead of provided meta information" do
    dorsey = Dorsey::Server.new do
      set :article_path, './spec/articles'
    end

    dorsey.articles[0][:date].should == '03/11/2010'
  end

  it "will create a summary from the body" do
    dorsey = Dorsey::Server.new do
      set :article_path, './spec/articles'
    end

    dorsey.articles[0][:summary].length.should == 34
    dorsey.articles[0][:summary].match /<p>This is the article text 1<\/p>/
    dorsey.articles[1][:summary].length.should == 34
    dorsey.articles[1][:summary].match /<p>This is the article text 2<\/p>/
  end

 it "will use the slug independently of the defined order in the article" do
    dorsey = Dorsey::Server.new do
      set :article_path, './spec/articles'
    end

    dorsey.articles[2][:slug].should == 'test_3_2_1'
    dorsey.articles[1][:slug].should == 'test_6_5_4'
    dorsey.articles[0][:slug].should == 'test-7-8-9'
  end

  it "will use the slug independently of the defined order in the article" do
    dorsey = Dorsey::Server.new do
      set :article_path, './spec/articles'
    end

    dorsey.articles[2][:slug].should == 'test_3_2_1'
    dorsey.articles[1][:slug].should == 'test_6_5_4'
    dorsey.articles[0][:slug].should == 'test-7-8-9'
  end

  it "will get articles by slug" do
    dorsey = Dorsey::Server.new do
      set :article_path, './spec/articles'
    end

    dorsey.get_by_slug('2010').count.should == 3
    dorsey.get_by_slug('2010/').count.should == 3
    dorsey.get_by_slug('2010/11').count.should == 2
    dorsey.get_by_slug('2010/11/').count.should == 2
    dorsey.get_by_slug('2010/11/02').count.should == 1
    dorsey.get_by_slug('2010/11/02/').count.should == 1
    dorsey.get_by_slug('2010/11/03/test-7-8-9').count.should == 1
    dorsey.get_by_slug('2010/11/03/test-7-8-9/').count.should == 1
  end

  it "will generate the url from host, prefix, and slug" do
    dorsey = Dorsey::Server.new do
      set :host, "http://localhost:3000"
      set :article_prefix, "blog"
      set :article_path, './spec/articles'
    end

    dorsey.articles[2][:url].should == 'http://localhost:3000/blog/2010/10/01/test_3_2_1/'
  end
end
