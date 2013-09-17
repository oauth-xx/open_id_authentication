require 'spec_helper'

describe OpenIdAuthentication do
  before do
    OpenIdAuthentication.store = :memory
  end

  describe ".new" do
    it "creates a Rack::OpenID" do
      OpenIdAuthentication.new({}).class.should == Rack::OpenID
    end
  end
end
