class Account
  include DataMapper::Resource

  property :id, String
  property :password, String
  property :description, String
  property :modified_at, Time
  property :created_at, Time

  def self.authorized(client_id, client_secret)
    client_id = client_id.strip unless client_id.nil?
    client_secret = client_secret.strip unless client_secret.nil?

    account = first(:id => client_id)
    puts "authorizing #{account.to_json}"

    (account.nil?) ? false : (client_secret == account.password)
  end
end