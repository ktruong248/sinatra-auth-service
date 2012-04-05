require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe AccessTokenResponseGenerator do

  it "should return new response" do
    response = AccessTokenResponseGenerator.generate("a", "b", 1)
    response.should_not be_nil
  end

  it "should return new response with the client id and scope set" do
    response = AccessTokenResponseGenerator.generate("a", "b", 1)
    response.client_id.should == "a"
    response.scope.should == "b"
  end

  it "should add expires second to generate expires time" do
    now = Time.now
    Time.should_receive(:now).and_return(now)

    response = AccessTokenResponseGenerator.generate("a", "b", 1)
    response.expires_time.should == now + 1
  end

  it "should have token set" do
    SecureRandom.should_receive(:hex).and_return("somehex")

    response = AccessTokenResponseGenerator.generate("a", "b", 1)
    response.token.should == "somehex"
  end
end