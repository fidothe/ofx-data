require "ofx/data/banking/statement/response"
require "ofx/data/banking/bank_account"
require "ofx/data/banking/balance"
require "ofx/data/banking/transaction"

module OFX::Data::Banking::Statement
  RSpec.describe Response do
    let(:transaction) { instance_double('OFX::Data::Banking::Transaction') }
    let(:account) { instance_double('OFX::Data::Banking::BankAccount') }
    let(:ledger_balance) { instance_double('OFX::Data::Banking::Balance') }
    let(:available_balance) { instance_double('OFX::Data::Banking::Balance') }
    let(:start_date) { Date.new(2016, 9, 20) }
    let(:end_date) { Date.new(2016, 9, 22) }
    subject {
      Response.new(curdef: :eur, account: account, ledger_balance: ledger_balance, available_balance: available_balance, start_date: start_date, end_date: end_date, transactions: [transaction])
    }

    it "has a curdef" do
      expect(subject.curdef).to eq(:eur)
    end

    it "has the correct account" do
      expect(subject.account).to be(account)
    end

    it "has a ledger balance" do
      expect(subject.ledger_balance).to be(ledger_balance)
    end

    it "has an available balance" do
      expect(subject.available_balance).to be(available_balance)
    end

    it "has a start date" do
      expect(subject.start_date).to be(start_date)
    end

    it "has an end date" do
      expect(subject.end_date).to be(end_date)
    end

    it "has a list of transactions" do
      expect(subject.transactions).to eq([transaction])
    end

    it "has an empty marketing text" do
      expect(subject.marketing_info).to eq("")
    end

    it "has an OFX type of :banking.statement.response" do
      expect(subject.ofx_type).to eq(:"banking.statement.response")
    end
  end
end
