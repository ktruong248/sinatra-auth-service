class AccessTokenResponseGenerator
  def self.generate(client_id, scope, expires_second=120)
    access_token_response = AccessTokenResponse.new
    access_token_response.client_id = client_id
    access_token_response.scope = scope
    access_token_response.token = SecureRandom.hex
    access_token_response.expires_time = Time.now + expires_second
    access_token_response
  end
end