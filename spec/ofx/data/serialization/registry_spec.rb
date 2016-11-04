require "ofx/data/serialization/registry"

module OFX::Data::Serialization
  RSpec.describe Registry do
    let(:serializer) { double }
    let(:entry) { Registry::Entry.new(serializer, :document) }

    it "can have entries added" do
      subject.register(entry)

      expect(subject.entries).to eq([entry])
    end

    context "matching" do
      let(:context_entry) { Registry::Entry.new(serializer, :document, :alt) }

      before do
        subject.register context_entry
        subject.register entry
      end

      it "returns the first matching entry" do
        expect(subject.matching_entry(:document, nil)).to be(entry)
      end

      it "passes both type and context name correctly" do
        expect(subject.matching_entry(:document, :alt)).to be(context_entry)
      end

      it "returns a SerializerNotFound error if there's no match" do
        expect {
          subject.matching_entry(:document, :neue)
        }.to raise_error(SerializerNotFoundError)
      end
    end

    it "returns the serializer instance from the matching entry" do
      subject.register(entry)

      expect(subject.serializer_for(:document)).to be(serializer)
    end

    it "has a convenience instance building method" do
      registry = Registry.build { |r|
        r.register(entry)
      }

      expect(registry.serializer_for(:document)).to be(serializer)
    end
  end
end
