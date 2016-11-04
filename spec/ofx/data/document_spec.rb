require "ofx/data/document"
require "ofx/data/message_sets"

module OFX::Data
  RSpec.describe Document do
    let(:message_sets) { instance_double(MessageSets) }
    subject { Document.new(message_sets: message_sets) }

    it "has an OFX declaration object" do
      expect(subject.declaration).to be_a(OFX::Data::Declaration)
    end

    it "is a response by default" do
      expect(subject.response?).to be(true)
      expect(subject.request?).to be(false)
    end

    it "has a collection of message sets" do
      expect(subject.message_sets).to be(message_sets)
    end

    it "reports that's its an OFX document object" do
      expect(subject.ofx_type).to eq(:document)
    end
  end
end
