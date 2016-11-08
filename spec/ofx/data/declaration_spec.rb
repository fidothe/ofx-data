require "ofx/data/declaration"

module OFX::Data
  RSpec.describe Declaration do
    it "can return a basic OFX 2.0.3 declaration" do
      declaration = Declaration[:"2.0.3"]

      expect(declaration.ofxheader).to eq("200")
      expect(declaration.version).to eq("203")
      expect(declaration.security).to eq("NONE")
      expect(declaration.oldfileuid).to eq("NONE")
      expect(declaration.newfileuid).to eq("NONE")
      expect(declaration.encoding).to eq("UTF-8")
    end

    it "can return a basic OFX 1.0.2 declaration" do
      declaration = Declaration[:"1.0.2"]

      expect(declaration.ofxheader).to eq("100")
      expect(declaration.version).to eq("102")
      expect(declaration.security).to eq("NONE")
      expect(declaration.oldfileuid).to eq("NONE")
      expect(declaration.newfileuid).to eq("NONE")
      expect(declaration.encoding).to eq("UTF-8")
    end

    it "returns a basic 2.0.3 declaration by default" do
      expect(Declaration.default.version).to eq("203")
    end
  end
end
