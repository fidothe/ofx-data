require "ofx/data"
require "nokogiri"
require "builder"

module OFX::Data::Serialization
  RSpec.describe Document do
    def strict_parse(xml)
      opts = Nokogiri::XML::ParseOptions.new.strict.norecover
      Nokogiri.XML(xml, nil, nil, opts)
    end

    let(:document) { OFX::Data::Document.new }
    let(:builder) { Builder::XmlMarkup.new }

    it "generates well-formed XML for an empty document" do
      Document.serialize(document, builder)

      expect { strict_parse(builder.target!) }.not_to raise_error
    end

    it "registers itself for the :document OFX type" do
      expect(OFX::Data::Serialization.registry.registered_for(Document))
        .to eq(:document)
    end
  end
end
