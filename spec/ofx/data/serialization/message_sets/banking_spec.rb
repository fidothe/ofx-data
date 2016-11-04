require "ofx/data/serialization/shared_examples"
require "ofx/data/serialization/message_sets/banking"
require "ofx/data/message_sets/banking"
require "builder"

module OFX::Data::Serialization::MessageSets::Banking
  RSpec.describe "Banking" do
    it "correctly serializes a Request"

    describe Response do
      let(:registry) { OFX::Data::Serialization::Registry.new }

      it_should_behave_like "a basic serializer", [:"message_sets.banking.response", nil], :"message_sets.banking.response", nil

      context "serialization" do
        subject { Response.new(registry) }

        let(:xml) { Builder::XmlMarkup.new }

        it "is correctly serialized" do
          data = OFX::Data::MessageSets::Banking::Response.new([])
          subject.serialize(data, xml)

          expect(xml.target!.strip).to eq("<BANKMSGSRSV1></BANKMSGSRSV1>")
        end

        it "hands off to message children correctly" do
          msg = double
          data = OFX::Data::MessageSets::Banking::Response.new([msg])

          expect(subject)
            .to receive(:serialize_collection).with([msg], xml)

          subject.serialize(data, xml)
        end
      end
    end
  end
end
