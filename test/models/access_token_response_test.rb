require 'minitest/autorun'
require_relative '../test_helper'
require_relative '../../models/access_token_response'

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
    assert_equal expected_json, @response.to_json
  end
end