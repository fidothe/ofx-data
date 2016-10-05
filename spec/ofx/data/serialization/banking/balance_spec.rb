require "ofx/data/serialization/banking/balance"
require "ofx/data/banking/balance"
require "builder"

module OFX::Data::Serialization::Banking
  RSpec.describe Balance do
    let(:builder) { Builder::XmlMarkup.new }
    let(:balance) {
      OFX::Data::Banking::Balance.new({
        amount: "100.00", date: DateTime.parse("2016-10-03T18:30:00Z")
      })
    }

    it "registers itself for the :banking.bank_account ofx type" do
        expect(OFX::Data::Serialization.registry.registered_for(Balance))
          .to eq(:"banking.balance")
    end

    it "generates sensible XML" do
      expected = "<BALAMT>100.0</BALAMT><DTASOF>20161003183000</DTASOF>"
      Balance.serialize(balance, builder)
      xml = builder.target!

      expect(xml).to eq(expected)
    end
  end
end
