RSpec.describe OpenIdAuthentication::Middleware do
  subject(:instance) { described_class.new({}) }

  describe "::new" do
    it "does not raise an error" do
      block_is_expected.to_not raise_error
    end

    it "creates a Rack::OpenID" do
      expect(instance.class).to eq(Rack::OpenID)
    end
  end
end
