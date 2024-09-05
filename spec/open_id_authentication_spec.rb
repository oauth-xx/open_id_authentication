RSpec.describe OpenIdAuthentication do
  describe "::store" do
    subject(:store) { OpenIdAuthentication.store = :memory }

    before do
      OpenIdAuthentication.store = nil
    end

    it "can be set to :memory" do
      block_is_expected.to change { OpenIdAuthentication.store.class }.from(NilClass).to(OpenID::Store::Memory)
    end
  end
end
