require "builder"
require "ofx/data/serialization/message_set"
require "ofx/data/message_set"

module OFX::Data::Serialization
  RSpec.describe MessageSet do
    let(:builder) { Builder::XmlMarkup.new }

    it "can order a list of MessageSets correctly" do
      b_msg = OFX::Data::MessageSet::Banking::Response.new([])
      s_msg = OFX::Data::MessageSet::Signon::Response.new
      message_sets = [b_msg, s_msg]

      expect(MessageSet.order_sets(message_sets)).to eq([s_msg, b_msg])
    end

    it "kicks off serialization correctly" do
      message_set = double
      ordered_message_set = double

      expect(MessageSet).to receive(:order_sets).with([message_set]) {
        [ordered_message_set]
      }

      expect(MessageSet).to receive(:serialize_collection)
        .with([ordered_message_set], builder)

      MessageSet.serialize([message_set], builder)
    end

    it "registers itself for the :message_sets OFX type" do
      expect(OFX::Data::Serialization.registry.registered_for(MessageSet))
        .to eq(:message_sets)
    end
  end
end
