require "ofx/data/serialization/shared_examples"
require "ofx/data/serialization/banking/statement/transaction"
require "ofx/data/banking/statement/transaction"
require "ofx/data/banking/statement/response"
require "ofx/data/transaction/status"
require "builder"

module OFX::Data::Serialization::Banking::Statement::Transaction
  RSpec.describe "Transaction" do
    let(:builder) { Builder::XmlMarkup.new }

    describe Response do
      it_should_behave_like "a basic serializer", [:"banking.statement.transaction.response", nil], :"banking.statement.transaction.response", nil

      context "serialization", :serializer do
        let(:status) { OFX::Data::Transaction::Status.new({
          code: 200, severity: :info
        }) }
        let(:response) {
          instance_double(OFX::Data::Banking::Statement::Response, {
            ofx_type: :"banking.statement.response"
          })
        }
        let(:transaction_data) {
          instance_double("OFX::Data::Banking::Transaction::Response", {
            trnuid: "123", status: status, response: response
          })
        }

        subject { Response.new(test_registry) }

        it "hands on to its children properly" do
          expect(subject).to receive(:serialize_collection)
            .with([status, response], builder)

          subject.serialize(transaction_data, builder)
        end

        it "generates a sensible XML response" do
          subject.serialize(transaction_data, builder)

          expect(builder.target!).to eq("<STMTTRNRS><TRNUID>123</TRNUID><null>transaction.status</null><null>banking.statement.response</null></STMTTRNRS>")
        end
      end
    end
  end
end
