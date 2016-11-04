require "ofx/data/serialization/registry"

RSpec.shared_examples "a basic serializer" do |default_registry_entry_args, ofx_type, context_name|
  let(:registry) { OFX::Data::Serialization::Registry.new }
  subject { described_class.new(registry) }

  context "the basics" do
    it "can return its registry" do
      expect(subject.registry).to be(registry)
    end

    it "has sensible default registry entry arguments" do
      expect(subject.default_registry_entry_args).to eq(default_registry_entry_args)
    end

    it "can make a Registry::Entry using the defaults" do
      entry = subject.registry_entry
      expect(entry.serializer).to be(subject)
      expect(entry.ofx_type).to eq(ofx_type)
      expect(entry.context_name).to eq(context_name)
    end

    it "can build and register a new instance" do
      serializer = instance_double(described_class)
      entry = instance_double(OFX::Data::Serialization::Registry::Entry)

      expect(described_class).to receive(:new).with(registry) { serializer }
      expect(serializer).to receive(:registry_entry) { entry }
      expect(registry).to receive(:register).with(entry)

      described_class.register_with(registry)
    end
  end
end
