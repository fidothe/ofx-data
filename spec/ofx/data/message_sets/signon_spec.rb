require "ofx/data/message_sets/signon"

class OFX::Data::MessageSets
  RSpec.describe Signon do
    context "Response" do
      let(:message) { double }
      subject { Signon::Response.new(message) }

      it "has a message_set_type of :signon" do
        subject.message_set_type
      end

      it "reports its message" do
        expect(subject.message).to be(message)
      end

      it "has an OFX type of :message_sets.signon.response" do
        expect(subject.ofx_type).to eq(:"message_sets.signon.response")
      end
    end
  end
end
