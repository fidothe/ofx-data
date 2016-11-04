require "ofx/data/serialization/shared_examples"
require "ofx/data/serialization/document"
require "ofx/data/document"
require "ofx/data/message_sets"
require "builder"

module OFX::Data::Serialization
  RSpec.describe Document do
    it_should_behave_like "a basic serializer", [:document, nil], :document, nil

    context "serialization", :serializer do
      let(:message_sets) { OFX::Data::MessageSets.new([]) }
      let(:document) { OFX::Data::Document.new(message_sets: message_sets) }
      let(:builder) { Builder::XmlMarkup.new }

      subject { Document.new(test_registry) }

      it "generates well-formed XML for an empty document" do
        subject.serialize(document, builder)

        expect { strict_parse(builder.target!) }.not_to raise_error
      end

      it "correctly hands its MessageSets on for serialization" do
        expect(subject).to receive(:serialize_object).with(message_sets, builder)

        subject.serialize(document, builder)
      end
    end
  end
end
