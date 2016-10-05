require "ofx/data/banking/balance"

module OFX::Data::Banking
  RSpec.describe Balance do
    subject {
      Balance.new(amount: "100.00", date: DateTime.parse("2016-09-23T12:45:32Z"))
    }

    it "returns its amount" do
      expect(subject.amount).to eq(BigDecimal.new("100.00"))
    end

    it "returns its date" do
      expect(subject.date).to eq(DateTime.parse("2016-09-23T12:45:32Z"))
    end

    it "reports that's its an OFX banking balance object" do
      expect(subject.ofx_type).to eq(:"banking.balance")
    end
  end
end
