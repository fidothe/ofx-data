RSpec.shared_examples "a registry entry" do
  it "responds to match?" do
    expect(subject).to respond_to(:match?)
  end

  it "can return its serialization instance" do
    expect(subject.serializer).to be(serializer)
  end
end
