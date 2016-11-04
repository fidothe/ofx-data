require "ofx/data/signon/response"

module OFX::Data::Signon
  RSpec.describe Response do
    let(:status) { instance_double('OFX::Data::Transaction::Status') }
    let(:dtserver) { Date.new(2016, 9, 20) }
    let(:language) { :deu }
    subject {
      Response.new(status: status, dtserver: dtserver, language: language)
    }

    it "reports its status" do
      expect(subject.status).to be(status)
    end

    it "reports its dtserver value" do
      expect(subject.dtserver).to be(dtserver)
    end

    it "reports its language" do
      expect(subject.language).to be(language)
    end

    it "has an OFX type of :signon.response" do
      expect(subject.ofx_type).to eq(:"signon.response")
    end
  end
end
