RSpec.describe OpenIdAuthentication do
  describe "::store" do
    subject(:store) { described_class.store = :memory }

    before do
      described_class.store = nil
    end

    it "can be set to :memory" do
      block_is_expected.to change { described_class.store.class }.from(NilClass).to(OpenID::Store::Memory)
    end
  end
end
