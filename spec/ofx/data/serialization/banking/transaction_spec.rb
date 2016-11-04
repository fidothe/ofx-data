require "ofx/data/serialization/shared_examples"
require "ofx/data/serialization/banking/transaction"
require "ofx/data/banking/transaction"
require "builder"

module OFX::Data::Serialization::Banking
  RSpec.describe Transaction do
    it_should_behave_like "a basic serializer", [:"banking.statement_transaction", nil], :"banking.statement_transaction", nil

    context "serialization" do
      let(:registry) { OFX::Data::Serialization::Registry.new }
      let(:builder) { Builder::XmlMarkup.new }
      let(:transaction) {
        OFX::Data::Banking::Transaction.new({
          type: :debit, amount: "100", fitid: "unique",
          date_posted: DateTime.parse("2016-10-02T12:00:00Z"), name: "ohai"
        })
      }

      subject { Transaction.new(registry) }

      it "generates sensible XML" do
        expected = "<STMTTRN><TRNTYPE>DEBIT</TRNTYPE><DTPOSTED>20161002120000</DTPOSTED><TRNAMT>100.0</TRNAMT><FITID>unique</FITID><NAME>ohai</NAME></STMTTRN>"
        subject.serialize(transaction, builder)
        xml = builder.target!

        expect(xml).to eq(expected)
      end
    end
  end
end
