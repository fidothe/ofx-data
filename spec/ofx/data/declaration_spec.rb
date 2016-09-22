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
    end

    it "returns a basic 2.0.3 declaration by default" do
      expect(Declaration.default.version).to eq("203")
    end
  end
end
