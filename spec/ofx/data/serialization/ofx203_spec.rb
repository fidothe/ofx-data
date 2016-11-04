require "ofx/data/serialization/ofx203"
require "ofx/data"

module OFX::Data::Serialization
  RSpec.describe OFX203 do
    let(:registry) { instance_double(Registry) }
    let(:object) { instance_double(OFX::Data::Document, ofx_type: :document) }
    let(:serializer) { double }
    let(:builder) { instance_double(Builder::XmlMarkup) }

    it "exposes a serialize method that takes an OFX::Data::Document" do
      allow(OFX203).to receive(:registry) { registry }
      allow(OFX203).to receive(:builder) { builder }

      expect(registry).to receive(:serializer_for).with(:document) { serializer }
      expect(serializer).to receive(:serialize).with(object, builder)
      expect(builder).to receive(:target!) { "result" }

      expect(OFX203.serialize(object)).to eq("result")
    end
  end
end
