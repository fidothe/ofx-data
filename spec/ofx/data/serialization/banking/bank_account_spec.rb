require "ofx/data/serialization/banking/bank_account"
require "ofx/data/banking/bank_account"
require "builder"

module OFX::Data::Serialization::Banking
  RSpec.describe BankAccount do
    let(:builder) { Builder::XmlMarkup.new }
    let(:account) {
      OFX::Data::Banking::BankAccount.new({
        bank_id: "123", account_id: "456", account_type: :checking
      })
    }

    it "registers itself for the :banking.bank_account ofx type" do
        expect(OFX::Data::Serialization.registry.registered_for(BankAccount))
          .to eq(:"banking.bank_account")
    end

    it "generates sensible XML" do
      expected = "<BANKID>123</BANKID><ACCTID>456</ACCTID><ACCTTYPE>CHECKING</ACCTTYPE>"
      BankAccount.serialize(account, builder)
      xml = builder.target!

      expect(xml).to eq(expected)
    end
  end
end
