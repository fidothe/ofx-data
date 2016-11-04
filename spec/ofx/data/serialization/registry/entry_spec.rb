require "ofx/data/serialization/registry/entry"
require "ofx/data/serialization/registry/shared_entry_examples"

class OFX::Data::Serialization::Registry
  RSpec.describe Entry do
    let(:serializer) { double }

    context "initialization" do
      it "requires a serializer instance and an OFX type" do
        expect {
          Entry.new(serializer, :document)
        }.to_not raise_error
      end

      it "allows a context name to be passed" do
        expect {
          Entry.new(:"banking.balance", :ledger)
        }.to_not raise_error
      end
    end

    it_behaves_like "a registry entry" do
      subject { Entry.new(serializer, :document) }
    end

    describe "matching" do
      context "without context" do
        subject { Entry.new(serializer, :type) }

        it "matches on OFX type only" do
          expect(subject.match?(:type)).to be(true)
        end

        it "doesn't match on OFX type + context" do
          expect(subject.match?(:type, :context_name)).to be(false)
        end
      end

      context "with context" do
        subject { Entry.new(serializer, :type, :context_name) }

        it "doesn't match on OFX type alone" do
          expect(subject.match?(:type)).to be(false)
        end

        it "matches on OFX type + context" do
          expect(subject.match?(:type, :context_name)).to be(true)
        end
      end
    end
  end
end
