require "ofx/data/transaction/status"

module OFX::Data::Transaction
  RSpec.describe Status do
    let(:base_opts) { {code: 0, severity: :info} }
    subject { Status.new(base_opts) }

    it "reports its OFX type as :transaction.status" do
      expect(subject.ofx_type).to eq(:"transaction.status")
    end

    context "code" do
      it "allows a numeric code" do
        expect(subject.code).to eq(0)
      end

      it "does not allow a string code" do
        expect {
          Status.new(base_opts.merge(code: "hello"))
        }.to raise_error(ArgumentError)
      end

      it "does not allow 7-digit numbers" do
        expect { Status.new(base_opts.merge(code: 999999)) }.not_to raise_error
        expect {
          Status.new(base_opts.merge(code: 1000000))
        }.to raise_error(ArgumentError)
      end
    end

    context "severity" do
      it "reports its severity" do
        expect(subject.severity).to eq(:info)
      end

      it "allows valid values" do
        [:info, :warn, :error].each do |level|
          expect {
            Status.new(base_opts.merge(severity: level))
          }.not_to raise_error
        end
      end

      it "does not allow an invalid value" do
        expect {
          Status.new(base_opts.merge(severity: :oops))
        }.to raise_error(ArgumentError)
      end
    end

    context "message" do
      it "defaults to nil" do
        expect(subject.message).to be(nil)
      end

      it "reports it when it's there" do
        status = Status.new(base_opts.merge(message: "hello"))
        expect(status.message).to eq("hello")
      end

      it "does not allow 256-char strings" do
        expect {
          Status.new(base_opts.merge(message: "A"*255))
        }.not_to raise_error
        expect {
          Status.new(base_opts.merge(message: "A"*256))
        }.to raise_error(ArgumentError)
      end
    end
  end
end
