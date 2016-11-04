require "ofx/data/serialization/shared_examples"
require "ofx/data/serialization/transaction/status"
require "ofx/data/transaction/status"
require "builder"

module OFX::Data::Serialization::Transaction
  RSpec.describe Status do
    it_should_behave_like "a basic serializer", [:"transaction.status", nil], :"transaction.status", nil

    context "serialization" do
      let(:registry) { OFX::Data::Serialization::Registry.new }
      let(:status) {
        OFX::Data::Transaction::Status.new(code: 0, severity: :info, message: "hello")
      }
      let(:builder) { Builder::XmlMarkup.new }

      subject { Status.new(registry) }

      it "generates sane XML for a status" do
        subject.serialize(status, builder)

        expect(builder.target!).to eq("<STATUS><CODE>0</CODE><SEVERITY>INFO</SEVERITY><MESSAGE>hello</MESSAGE></STATUS>")
      end
    end
  end
end
