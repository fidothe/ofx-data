require "ofx/data/banking/transaction"
require "ofx/data/banking/bank_account"

module OFX::Data::Banking
  RSpec.describe Transaction do
    let(:base_opts) { {
      type: :credit, date_posted: Date.parse("2016-09-22"),
      amount: "100", fitid: "abc"
    } }
    subject {
      Transaction.new(base_opts)
    }

    context "type" do
      it "returns the transaction type" do
        expect(subject.type).to eq(:credit)
      end

      it "allows any of the valid values" do
        [
          :credit, :debit, :int, :div, :fee, :srvchg, :dep, :atm, :pos, :xfer,
          :check, :payment, :cash, :directdep, :directdebit, :repeatpmt, :other
        ].each do |val|
          transaction = Transaction.new(base_opts.merge(type: val))
          expect(transaction.type).to eq(val)
        end
      end

      it "rejects an invalid value" do
        expect {
          Transaction.new(base_opts.merge(type: :parachute))
        }.to raise_error(ArgumentError)
      end
    end

    it "returns the date posted" do
      expect(subject.date_posted).to eq(Date.parse("2016-09-22"))
    end

    it "returns the transaction amount" do
      expect(subject.amount).to eq(BigDecimal.new("100"))
    end

    it "returns the fitid" do
      expect(subject.fitid).to eq("abc")
    end

    context "bank_account_to" do
      it "returns nil by default" do
        expect(subject.bank_account_to).to be(nil)
      end

      it "returns the BankAccount if it's there" do
        account = instance_double("OFX::Data::Banking::BankAccount")
        transaction = Transaction.new(base_opts.merge(bank_account_to: account))
        expect(transaction.bank_account_to).to be(account)
      end
    end

    context "name" do
      it "returns nil by default" do
        expect(subject.name).to be(nil)
      end

      it "returns the name if it's there" do
        transaction = Transaction.new(base_opts.merge(name: "A name"))
        expect(transaction.name).to eq("A name")
      end

      it "rejects an invalid value" do
        expect {
          Transaction.new(base_opts.merge(name: "A"*33))
        }.to raise_error(ArgumentError)
      end
    end

    context "refnum" do
      it "returns nil by default" do
        expect(subject.refnum).to be(nil)
      end

      it "returns it if it's there" do
        transaction = Transaction.new(base_opts.merge(refnum: "Ref 123"))
        expect(transaction.refnum).to eq("Ref 123")
      end

      it "rejects an invalid value" do
        expect {
          Transaction.new(base_opts.merge(refnum: "A"*33))
        }.to raise_error(ArgumentError)
      end
    end

    context "payee_id" do
      it "returns nil by default" do
        expect(subject.payee_id).to be(nil)
      end

      it "returns it if it's there" do
        transaction = Transaction.new(base_opts.merge(payee_id: "P 123"))
        expect(transaction.payee_id).to eq("P 123")
      end

      it "rejects an invalid value" do
        expect {
          Transaction.new(base_opts.merge(payee_id: "A"*13))
        }.to raise_error(ArgumentError)
      end
    end

    context "memo" do
      it "returns nil by default" do
        expect(subject.memo).to be(nil)
      end

      it "returns it if it's there" do
        transaction = Transaction.new(base_opts.merge(memo: "Blah"))
        expect(transaction.memo).to eq("Blah")
      end

      it "rejects a value that's too long" do
        expect {
          Transaction.new(base_opts.merge(memo: "A"*256))
        }.to raise_error(ArgumentError)
      end
    end

    describe "generating a Transaction with a synthetic fitid" do
      let(:account) {
        instance_double("OFX::Data::Banking::BankAccount", fitid_str: "1234abcd")
      }
      let(:base_opts) { {
        type: :credit, amount: "100", bank_account_to: account
      } }
      let(:date) { Date.parse("2016-09-24") }
      let(:opts) { base_opts.merge(date_posted: date) }

      context "two transactions on the same day" do
        it "generate the same fitid with identical data" do
          t1 = Transaction.with_synthetic_fitid(opts)
          t2 = Transaction.with_synthetic_fitid(opts)
          expect(t1.fitid).to eq(t2.fitid)
        end

        it "generate different fitids with non-identical data" do
          t1 = Transaction.with_synthetic_fitid(opts)
          t2 = Transaction.with_synthetic_fitid(opts.merge(amount: "200"))
          expect(t1.fitid).to_not eq(t2.fitid)
        end
      end

      context "two transactions on different days" do
        it "generate a different fitid with otherwise identical data" do
          t1 = Transaction.with_synthetic_fitid(opts)
          t2 = Transaction.with_synthetic_fitid(opts.merge(date_posted: date + 1))
          expect(t1.fitid).to_not eq(t2.fitid)
        end
      end
    end

    it "reports that's its an OFX banking.statement_transaction object" do
      expect(subject.ofx_type).to eq(:"banking.statement_transaction")
    end
  end
end
