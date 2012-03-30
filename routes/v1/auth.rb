class MyApp < Sinatra::Base
  helpers Sinatra::Jsonp

  before do
    content_type :json
  end

  #
  # todo cleanup
  # think about scope hashed ??
  # should we use scope for "request authorize url"
  get '/auth/v1/access_token' do
    client_id = params[:client_id]
    client_secret = params[:client_secret]
    scope = params[:scope]

    if Account.authorized(client_id, client_secret)
      token = SecureRandom.hex
      # to do add configuration
      expires_second = 120
      @access_token_response = AccessTokenResponse.new
      @access_token_response.client_id = client_id
      @access_token_response.scope = scope
      @access_token_response.token = token
      @access_token_response.expires_time = Time.now + expires_second
      @@memcache_client.add(token, @access_token_response, expires_second)
    end

    JSONP @access_token_response
  end

  #
  # add more validate to compare the access_token is valid for the request url ?
  #
  get '/auth/v1/validate' do

    access_token = params[:access_token]
    scope = params[:scope]

    value = @@memcache_client.get access_token

    if value.nil?
      status 404
      JSONP ErrorResponse.new(100, "invalid token")
    elsif value.scope != scope
      puts "shoud return 101"
      JSONP ErrorResponse.new(101, "invalid scope")
    else
      JSONP value
    end

  end
end