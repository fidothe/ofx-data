require "ofx/data/serialization/banking/transaction"
require "ofx/data/banking/transaction"
require "ofx/data/banking/bank_account"
require "builder"

module OFX::Data::Serialization::Banking
  RSpec.describe Transaction do
    let(:builder) { Builder::XmlMarkup.new }
    let(:transaction) {
      OFX::Data::Banking::Transaction.new({
        type: :debit, amount: "100", fitid: "unique",
        date_posted: DateTime.parse("2016-10-02T12:00:00Z"), name: "ohai"
      })
    }

    it "registers itself for the :banking.bank_account ofx type" do
        expect(OFX::Data::Serialization.registry.registered_for(Transaction))
          .to eq(:"banking.statement_transaction")
    end

    it "generates sensible XML" do
      expected = "<STMTTRN><TRNTYPE>DEBIT</TRNTYPE><DTPOSTED>20161002120000</DTPOSTED><TRNAMT>100.0</TRNAMT><FITID>unique</FITID><NAME>ohai</NAME></STMTTRN>"
      Transaction.serialize(transaction, builder)
      xml = builder.target!

      expect(xml).to eq(expected)
    end
  end
end
