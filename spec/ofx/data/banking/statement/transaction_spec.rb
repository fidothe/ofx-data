require "ofx/data/banking/statement/transaction"

module OFX::Data::Banking::Statement
  RSpec.describe Transaction do
    let(:status) { double }
    let(:response) { double }
    let(:base_opts) { {trnuid: "abc", status: status, response: response} }
    subject { Transaction::Response.new(base_opts) }

    it "reports its OFX type as :banking.statement.transaction.response" do
      expect(subject.ofx_type).to eq(:"banking.statement.transaction.response")
    end

    it "reports its trnuid" do
      expect(subject.trnuid).to eq("abc")
    end

    it "reports its status" do
      expect(subject.status).to be(status)
    end

    it "reports its response" do
      expect(subject.response).to be(response)
    end
  end
end

