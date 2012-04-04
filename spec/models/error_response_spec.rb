require File.expand_path(File.join(File.dirname(__FILE__), "..", 'spec_helper'))

describe ErrorResponse do
  before do
    @response = ErrorResponse.new(111, "some error description")
  end

  it "should serialize to json string" do
    expected_json = "{\"error_code\":111,\"description\":\"some error description\"}"
    @response.to_json.should == expected_json
  end
end