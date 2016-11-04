require "ofx/data/serialization/shared_examples"
require "ofx/data/serialization/message_sets/Signon"
require "ofx/data/message_sets/signon"
require "ofx/data/signon/response"
require "builder"

module OFX::Data::Serialization::MessageSets::Signon
  RSpec.describe "Banking" do
    it "correctly serializes a Request"

    describe Response do
      it_should_behave_like "a basic serializer", [:"message_sets.signon.response", nil], :"message_sets.signon.response", nil

      context "serialization", :serializer do
        let(:message) { instance_double(OFX::Data::Signon::Response, ofx_type: :"signon.response") }
        let(:data) { OFX::Data::MessageSets::Signon::Response.new(message) }
        subject { Response.new(test_registry) }

        let(:builder) { Builder::XmlMarkup.new }

        it "is correctly serialized" do
          subject.serialize(data, builder)

          expect(builder.target!.strip).to eq("<SIGNONMSGSRSV1><null>signon.response</null></SIGNONMSGSRSV1>")
        end

        it "hands off to its message correctly" do
          expect(subject).to receive(:serialize_object).with(message, builder)

          subject.serialize(data, builder)
        end
      end
    end
  end
end
