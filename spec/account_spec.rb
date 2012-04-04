require File.expand_path(File.join(File.dirname(__FILE__), 'spec_helper'))

describe Account do

  before do
    @client_id = "some client id"
    @client_secret = "secret"

    @account = Account.new
    @account.id = "some id"
    @account.password = "secret"
  end

  it "should authorized with found account and matching password" do
    Account.should_receive(:first).with(:id => @client_id).and_return(@account)
    Account.authorized(@client_id, @client_secret).should be_true
  end

  it "should return false with found account but not matching password" do
    @account.password = "some other password"
    Account.should_receive(:first).with(:id => @client_id).and_return(@account)
    Account.authorized(@client_id, @client_secret).should be_false
  end

  it "should return false for not found account" do
    Account.should_receive(:first).with(:id => @client_id).and_return(nil)
    Account.authorized(@client_id, @client_secret).should be_false
  end
end