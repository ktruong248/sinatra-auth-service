require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')
require File.join(File.dirname(__FILE__), '../../../', 'app.rb')

set :environment, :test

describe "MyApp::Auth routes" do
  include Rack::Test::Methods

  def app
    @app = MyApp.new
  end

  describe "access_token" do

    before do
      @client_id = "some client id"
      @client_secret = "secret"
      @token = "some random token"
      @expires_second = 120
    end

    describe "success authorized" do
      before do
        @access_token_response = AccessTokenResponse.new
      end

      it "response header should contain Application/json" do
        Account.should_receive(:authorized).with(@client_id, @client_secret).and_return(true)
        AccessTokenResponseGenerator.should_receive(:generate).with(@client_id, nil, @expires_second).and_return(@access_token_response)
        @@memcache_client.should_receive(:add).with(@access_token_response.token, kind_of(AccessTokenResponse), @expires_second)

        get '/auth/v1/access_token', :client_id => @client_id, :client_secret => @client_secret
        last_response.headers.should include({"Content-Type" => "application/json;charset=utf-8"})
      end

      it 'should return status 200 after valid authorized' do
        Account.should_receive(:authorized).with(@client_id, @client_secret).and_return(true)
        AccessTokenResponseGenerator.should_receive(:generate).with(@client_id, nil, @expires_second).and_return(@access_token_response)
        @@memcache_client.should_receive(:add).with(@access_token_response.token, kind_of(AccessTokenResponse), 120)

        get '/auth/v1/access_token', :client_id => @client_id, :client_secret => @client_secret
        last_response.status.should == 200
      end

      it "should call AccessTokenResponseGenerator to generate response" do
        Account.should_receive(:authorized).with(@client_id, @client_secret).and_return(true)
        AccessTokenResponseGenerator.should_receive(:generate).with(@client_id, @scope, @expires_second).and_return(@access_token_response)
        @@memcache_client.should_receive(:add).with(@access_token_response.token, @access_token_response, @expires_second)

        get '/auth/v1/access_token', :client_id => @client_id, :client_secret => @client_secret, :scope => @scope
      end
    end

    describe "failure authorized" do
      it 'should return status 400 for invalid authorized' do
        Account.should_receive(:authorized).with(@client_id, @client_secret).and_return(false)

        get '/auth/v1/access_token', :client_id => @client_id, :client_secret => @client_secret
        last_response.status.should == 400
      end

      it 'should return error response for invalid authorized' do
        Account.should_receive(:authorized).with(@client_id, @client_secret).and_return(false)

        get '/auth/v1/access_token', :client_id => @client_id, :client_secret => @client_secret
        last_response.body.should == "{\"error_code\":102,\"description\":\"invalid credentials\"}"
        last_response.headers.should include({"Content-Type" => "application/json;charset=utf-8"})
      end
    end
  end
end