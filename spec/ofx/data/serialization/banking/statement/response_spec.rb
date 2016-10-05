require "ofx/data/serialization/banking/statement/response"
require "ofx/data/serialization/banking/bank_account"
require "ofx/data/serialization/banking/balance"
require "ofx/data/serialization/banking/transaction"
require "ofx/data/serialization/banking/statement/response"
require "ofx/data/banking/statement/response"
require "ofx/data/banking/bank_account"
require "ofx/data/banking/balance"
require "ofx/data/banking/transaction"
require "builder"

module OFX::Data::Serialization::Banking
  RSpec.describe Statement do
    let(:builder) { Builder::XmlMarkup.new }

    context "Response" do
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
        instance_double("OFX::Data::Banking::Statement::Response", {
          curdef: :eur,
          start_date: DateTime.parse("2016-10-02T11:11:11Z"),
          end_date: DateTime.parse("2016-10-03T14:54:51Z"),
          account: account,
          ledger_balance: balance,
          available_balance: balance,
          transactions: [transaction]
        })
      }

      it "registers itself for the :banking.transaction.response ofx type" do
        expect(OFX::Data::Serialization.registry.registered_for(Statement::Response))
          .to eq(:"banking.statement.response")
      end

      it "generates a sensible XML response" do
        Statement::Response.serialize(data, builder)
        xml = builder.target!
        expected = "<STMTRS><CURDEF>EUR</CURDEF><BANKACCTFROM><BANKID>123</BANKID><ACCTID>456</ACCTID><ACCTTYPE>CHECKING</ACCTTYPE></BANKACCTFROM><BANKTRANLIST><DTSTART>20161002111111</DTSTART><DTEND>20161003145451</DTEND><STMTTRN><TRNTYPE>DEBIT</TRNTYPE><DTPOSTED>20161002120000</DTPOSTED><TRNAMT>100.0</TRNAMT><FITID>unique</FITID><NAME>ohai</NAME></STMTTRN></BANKTRANLIST><LEDGERBAL><BALAMT>100.0</BALAMT><DTASOF>20161003183000</DTASOF></LEDGERBAL><AVAILBAL><BALAMT>100.0</BALAMT><DTASOF>20161003183000</DTASOF></AVAILBAL></STMTRS>"
        expect(xml).to eq(expected)
      end
    end
  end
end
