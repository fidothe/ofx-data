require "ofx/data/message_sets/banking"
require "ofx/data/banking/statement"

class OFX::Data::MessageSets
  RSpec.describe Banking do
    context "Response" do
      let(:message) { instance_double("OFX::Data::Banking::Statement::Response") }
      subject { Banking::Response.new([message]) }

      it "has a message_set_type of :banking" do
        subject.message_set_type
      end

      it "can hold a list of messages" do
        expect(subject.messages).to eq([message])
      end

      it "has an OFX type of :message_sets.banking.response" do
        expect(subject.ofx_type).to eq(:"message_sets.banking.response")
      end
    end
  end
end
