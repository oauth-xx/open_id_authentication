RSpec.describe OpenIdAuthentication::Middleware do
  subject(:instance) { described_class.new({}) }

  before do
    OpenIdAuthentication.store = :memory
  end

  describe "::new" do
    it "does not raise an error" do
      block_is_expected.not_to raise_error
    end

    it "creates a Rack::OpenID" do
      expect(instance.class).to eq(Rack::OpenID)
    end
  end
end
