require "ofx/data/serialization/shared_examples"
require "ofx/data/serialization/banking/balance"
require "ofx/data/banking/balance"
require "builder"

module OFX::Data::Serialization::Banking
  RSpec.describe Balance do
    it_should_behave_like "a basic serializer", [:"banking.balance", nil], :"banking.balance", nil

    context "serialization", :serializer do
      let(:builder) { Builder::XmlMarkup.new }
      let(:balance) {
        OFX::Data::Banking::Balance.new({
          amount: "100.00", date: DateTime.parse("2016-10-03T18:30:00Z")
        })
      }
      subject { Balance.new(empty_registry) }

      it "generates sensible XML" do
        expected = "<BALAMT>100.0</BALAMT><DTASOF>20161003183000</DTASOF>"
        subject.serialize(balance, builder)
        xml = builder.target!

        expect(xml).to eq(expected)
      end
    end
  end
end
