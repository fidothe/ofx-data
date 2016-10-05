require "ofx/data/serialization/banking/statement/transaction"
require "ofx/data/banking/statement/transaction"
require "ofx/data/transaction/status"
require "builder"

module OFX::Data::Serialization::Banking::Statement
  RSpec.describe Transaction do
    let(:builder) { Builder::XmlMarkup.new }

    context "Response" do
      let(:status) { double() }
      let(:response) { double() }
      let(:transaction_data) {
        instance_double("OFX::Data::Banking::Transaction::Response", {
          trnuid: "123", status: status, response: response
        })
      }

      it "orders the status / response correctly" do
        expect(Transaction::Response.children(transaction_data))
          .to eq([status, response])
      end

      it "hands on to its children properly" do
        expect(Transaction::Response).to receive(:serialize_collection)
          .with([status, response], builder)

        Transaction::Response.serialize(transaction_data, builder)
      end

      it "registers itself for the :banking.transaction.response ofx type" do
        expect(OFX::Data::Serialization.registry.registered_for(Transaction::Response))
          .to eq(:"banking.statement.transaction.response")
      end

      it "generates a sensible XML response" do
        allow(Transaction::Response).to receive(:children) { [] }

        Transaction::Response.serialize(transaction_data, builder)

        expect(builder.target!).to eq("<STMTTRNRS><TRNUID>123</TRNUID></STMTTRNRS>")
      end
    end
  end
end
