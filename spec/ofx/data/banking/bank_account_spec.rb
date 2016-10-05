require "ofx/data/banking/bank_account"

module OFX::Data::Banking
  RSpec.describe BankAccount do
    let(:base_opts) {
      {bank_id: "123123", account_id: "456456", account_type: :checking}
    }
    subject { BankAccount.new(base_opts) }

    describe "bank identifier" do
      it "returns the bank id" do
        expect(subject.bank_id).to eq("123123")
      end

      it "doesn't permit id > 9 characters" do
        expect {
          BankAccount.new(base_opts.merge(bank_id: "1234567890"))
        }.to raise_error(ArgumentError)
      end
    end

    describe "branch identifier" do
      it "returns the branch id" do
        account = BankAccount.new(base_opts.merge(branch_id: "123"))
        expect(account.branch_id).to eq("123")
      end

      it "doesn't permit id > 22 characters" do
        expect {
          BankAccount.new(base_opts.merge(branch_id: "12345678901234567890123"))
        }.to raise_error(ArgumentError)
      end

      it "defaults empty" do
        expect(subject.branch_id).to eq("")
      end
    end

    describe "account ID" do
      it "returns the ID" do
        expect(subject.account_id).to eq("456456")
      end

      it "doesn't permit id > 22 characters" do
        expect {
          BankAccount.new(base_opts.merge(account_id: "12345678901234567890123"))
        }.to raise_error(ArgumentError)
      end
    end

    describe "account type" do
      it "returns the account type" do
        expect(subject.account_type).to eq(:checking)
      end

      it "allows each of the valid values" do
        [:checking, :savings, :money_market, :credit_line].each do |val|
          account = BankAccount.new(base_opts.merge(account_type: val))
          expect(account.account_type).to eq(val)
        end
      end

      it "doesn't permit an invalid value" do
        expect {
          account = BankAccount.new(base_opts.merge(account_type: :credit_card))
        }.to raise_error(ArgumentError)
      end
    end

    describe "account key" do
      it "returns the account key" do
        account = BankAccount.new(base_opts.merge(account_key: "123"))
        expect(account.account_key).to eq("123")
      end

      it "doesn't permit > 22 characters" do
        expect {
          BankAccount.new(base_opts.merge(account_key: "12345678901234567890123"))
        }.to raise_error(ArgumentError)
      end

      it "defaults empty" do
        expect(subject.account_key).to eq("")
      end
    end

    describe "hashable id in a statement transaction" do
      it "different data generates a different fitid_sha" do
        a1 = BankAccount.new(base_opts)
        a2 = BankAccount.new(base_opts.merge(account_key: "123"))

        expect(a1.fitid_str).to_not eq(a2.fitid_str)
      end
    end

    it "reports that's its an OFX banking.bank_account object" do
      expect(subject.ofx_type).to eq(:"banking.bank_account")
    end
  end
end
