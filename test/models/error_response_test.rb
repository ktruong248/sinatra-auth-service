require 'minitest/autorun'
require_relative '../test_helper'
require_relative '../../models/error_response'

describe ErrorResponse do
  before do
    @response = ErrorResponse.new(111, "some error description")
  end

  it "should serialize to json string" do
    expected_json = "{\"error_code\":111,\"description\":\"some error description\"}"
    assert_equal expected_json, @response.to_json
  end
end