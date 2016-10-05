require "ofx/data/document"

RSpec.describe OFX::Data::Document do
  it "has an OFX declaration object" do
    expect(subject.declaration).to be_a(OFX::Data::Declaration)
  end

  it "is a response by default" do
    expect(subject.response?).to be(true)
    expect(subject.request?).to be(false)
 end

  it "has a collection of message sets" do
    expect(subject.message_sets).to eq([])
  end

  it "reports that's its an OFX document object" do
    expect(subject.ofx_type).to eq(:document)
  end
end
