require "builder"
require "ofx/data/serialization/shared_examples"
require "ofx/data/serialization/message_sets"
require "ofx/data/message_sets"

module OFX::Data::Serialization
  RSpec.describe MessageSets do
    let(:builder) { Builder::XmlMarkup.new }

    it_should_behave_like "a basic serializer", [:message_sets, nil], :message_sets, nil

    context "serialization" do
      let(:registry) { instance_double(Registry) }
      subject { MessageSets.new(registry) }

      it "kicks off serialization correctly" do
        message_sets = instance_double(OFX::Data::MessageSets)

        expect(subject).to receive(:serialize_collection)
          .with(message_sets, builder)

        subject.serialize(message_sets, builder)
      end
    end
  end
end
