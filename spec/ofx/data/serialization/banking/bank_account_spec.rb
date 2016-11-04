require "ofx/data/serialization/shared_examples"
require "ofx/data/serialization/banking/bank_account"
require "ofx/data/banking/bank_account"
require "builder"

module OFX::Data::Serialization::Banking
  RSpec.describe BankAccount do
    it_should_behave_like "a basic serializer", [:"banking.bank_account", nil], :"banking.bank_account", nil

    context "serialization" do
      let(:registry) { OFX::Data::Serialization::Registry.new }
      let(:builder) { Builder::XmlMarkup.new }
      let(:account) {
        OFX::Data::Banking::BankAccount.new({
          bank_id: "123", account_id: "456", account_type: :checking
        })
      }

      subject { BankAccount.new(registry) }

      it "generates sensible XML" do
        expected = "<BANKID>123</BANKID><ACCTID>456</ACCTID><ACCTTYPE>CHECKING</ACCTTYPE>"
        subject.serialize(account, builder)
        xml = builder.target!

        expect(xml).to eq(expected)
      end
    end
  end
end
