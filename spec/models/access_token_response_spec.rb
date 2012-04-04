require File.expand_path(File.join(File.dirname(__FILE__), "..", 'spec_helper'))

describe AccessTokenResponse do
  before do
    @response = AccessTokenResponse.new
  end

  it "should serialize to json string" do
    @response.client_id = "client it"
    now = Time.now
    @response.expires_time = now
    @response.token = "some token"
    @response.scope = " some scope"
    expected_json = "{\"expires_time\":\"#{now}\",\"client_id\":\"client it\",\"token\":\"some token\",\"scope\":\" some scope\"}"
    @response.to_json.should == expected_json
  end
end