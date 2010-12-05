require File.dirname(__FILE__) + '/spec_helper'

describe "WebApplication" do

  include Rack::Test::Methods

  def app
    @app ||= WebApplication
  end

  it "will respond to /blog/index" do
    get '/blog/index'
    last_response.should be_ok
#      last_response.title.should == 'Cre8ive Thought'
  end
end
