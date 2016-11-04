require "ofx/data/serialization/shared_examples"
require "ofx/data/serialization/signon/response"
require "ofx/data/signon/response"
require "ofx/data/transaction/status"
require "builder"

module OFX::Data::Serialization::Signon
  RSpec.describe "Signon" do
    context Response do
      it_should_behave_like "a basic serializer", [:"signon.response", nil], :"signon.response", nil

      context "serialization", :serializer do
        let(:builder) { Builder::XmlMarkup.new }
        let(:status) {
          OFX::Data::Transaction::Status.new(code: 0, severity: :info)
        }
        let(:dtserver) { DateTime.parse("2016-10-03T18:30:00Z") }
        let(:language) { :deu }
        let(:data) {
          OFX::Data::Signon::Response.new({
            status: status,
            dtserver: dtserver,
            language: language
          })
        }
        let(:registry) { test_registry }

        subject { Response.new(registry) }

        it "generates a sensible XML response" do
          subject.serialize(data, builder)
          xml = builder.target!
          expected = "<SONRS><null>transaction.status</null><DTSERVER>20161003183000</DTSERVER><LANGUAGE>DEU</LANGUAGE></SONRS>"
          expect(xml).to eq(expected)
        end
      end
    end
  end
end
