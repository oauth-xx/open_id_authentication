require 'spec_helper'

describe OpenIdAuthentication do
  before do
    OpenIdAuthentication.store = :memory
  end

  it "has a version" do
    OpenIdAuthentication::VERSION.should =~ /^\d+\.\d+\.\d+$/
  end

  describe ".new" do
    it "creates a Rack::OpenID" do
      OpenIdAuthentication::Middleware.new({}).class.should == Rack::OpenID
    end
  end
end
