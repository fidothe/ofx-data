require "ofx/data/serialization/transaction/status"
require "ofx/data/transaction/status"
require "builder"

module OFX::Data::Serialization::Transaction
  RSpec.describe Status do
    let(:status) {
      OFX::Data::Transaction::Status.new(code: 0, severity: :info, message: "hello")
    }
    let(:builder) { Builder::XmlMarkup.new }

    it "generates sane XML for a status" do
      Status.serialize(status, builder)

      expect(builder.target!).to eq("<STATUS><CODE>0</CODE><SEVERITY>INFO</SEVERITY><MESSAGE>hello</MESSAGE></STATUS>")
    end

    it "registers itself for the :transaction.status OFX type" do
      expect(OFX::Data::Serialization.registry.registered_for(Status))
        .to eq(:"transaction.status")
    end
  end
end
