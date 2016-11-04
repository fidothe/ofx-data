require "ofx/data/message_sets"

module OFX::Data
  RSpec.describe MessageSets do
    let(:b_msg) { MessageSets::Banking::Response.new([]) }
    let(:s_msg) { MessageSets::Signon::Response.new(double) }
    subject { MessageSets.new([b_msg, s_msg]) }

    it "can order a MessageSet list correctly" do
      expect(subject.ordered_sets).to eq([s_msg, b_msg])
    end

    it "can be iterated across in order" do
      collector = []

      subject.each { |msg| collector << msg }

      expect(collector).to eq([s_msg, b_msg])
    end


    it "reports that's its an OFX Message Sets object" do
      expect(subject.ofx_type).to eq(:message_sets)
    end
  end
end
