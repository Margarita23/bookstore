
describe "User" do
  describe "abilities" do
    subject(:ability){ Ability.new(user) }
    let(:user){ nil }

    context "when is a guest" do
      let(:user){ Factory(:user) }

      it{ should be_able_to(:manage, Account.new) }
    end
  end
end