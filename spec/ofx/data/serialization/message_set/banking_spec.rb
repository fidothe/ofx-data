require "ofx/data/serialization/message_set/banking"
require "ofx/data/message_set/banking"
require "builder"

module OFX::Data::Serialization::MessageSet
  RSpec.describe Banking do
    it "correctly serializes a Request"

    context "Response" do
      let(:xml) { Builder::XmlMarkup.new }

      it "is correctly serialized" do
        data = OFX::Data::MessageSet::Banking::Response.new([])
        Banking::Response.serialize(data, xml)

        expect(xml.target!.strip).to eq("<BANKMSGSRSV1></BANKMSGSRSV1>")
      end

      it "hands off to message children correctly" do
        msg = double
        data = OFX::Data::MessageSet::Banking::Response.new([msg])

        expect(Banking::Response)
          .to receive(:serialize_collection).with([msg], xml)

        Banking::Response.serialize(data, xml)
      end

      it "registers itself for the :message_sets.banking.response OFX type" do
        expect(OFX::Data::Serialization.registry.registered_for(Banking::Response))
          .to eq(:"message_sets.banking.response")
      end
    end
  end
end
