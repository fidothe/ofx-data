require "ofx/data/serialization/shared_examples"
require "ofx/data/serialization/banking/statement/response"
require "ofx/data/banking/statement/response"
require "ofx/data/banking/bank_account"
require "ofx/data/banking/balance"
require "ofx/data/banking/transaction"
require "builder"

module OFX::Data::Serialization::Banking::Statement
  RSpec.describe "Statement" do
    context Response do
      it_should_behave_like "a basic serializer", [:"banking.statement.response", nil], :"banking.statement.response", nil

      context "serialization", :serializer do
        let(:builder) { Builder::XmlMarkup.new }
        let(:account) {
          OFX::Data::Banking::BankAccount.new({
            bank_id: "123", account_id: "456", account_type: :checking
          })
        }
        let(:balance) {
          OFX::Data::Banking::Balance.new({
            amount: "100.00", date: DateTime.parse("2016-10-03T18:30:00Z")
          })
        }
        let(:transaction) {
          OFX::Data::Banking::Transaction.new({
            type: :debit, amount: "100", fitid: "unique",
            date_posted: DateTime.parse("2016-10-02T12:00:00Z"), name: "ohai"
          })
        }
        let(:data) {
          OFX::Data::Banking::Statement::Response.new({
            curdef: :eur,
            start_date: DateTime.parse("2016-10-02T11:11:11Z"),
            end_date: DateTime.parse("2016-10-03T14:54:51Z"),
            account: account,
            ledger_balance: balance,
            available_balance: balance,
            transactions: [transaction]
          })
        }
        let(:registry) { test_registry }

        subject { Response.new(registry) }

        it "generates a sensible XML response" do
          subject.serialize(data, builder)
          xml = builder.target!
          expected = "<STMTRS><CURDEF>EUR</CURDEF><BANKACCTFROM><null>banking.bank_account</null></BANKACCTFROM><BANKTRANLIST><DTSTART>20161002111111</DTSTART><DTEND>20161003145451</DTEND><null>banking.statement_transaction</null></BANKTRANLIST><LEDGERBAL><null>banking.balance</null></LEDGERBAL><AVAILBAL><null>banking.balance</null></AVAILBAL></STMTRS>"
          expect(xml).to eq(expected)
        end
      end
    end
  end
end
