class AccessTokenResponse
  attr_accessor :client_id, :expires_time, :token, :scope

  def to_json(*a)
    {
      "expires_time" => @expires_time,
      "client_id" => @client_id,
      "token" => @token,
      "scope" => @scope
    }.to_json(*a)
  end
end