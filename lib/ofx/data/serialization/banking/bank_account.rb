require "ofx/data/serialization"
require "ofx/data/serialization/common"

module OFX
  module Data
    module Serialization
      module Banking
        class BankAccount
          extend Serialization::Common
          ACCT_TYPES = {
            checking: "CHECKING".freeze,
            savings: "SAVINGS".freeze,
            money_market: "MONEYMRKT".freeze,
            credit_line: "CREDITLINE"
          }

          def self.serialize(bank_account, builder)
            builder.BANKID bank_account.bank_id
            if bank_account.branch_id != ""
              builder.BRANCHID bank_account.branch_id
            end
            builder.ACCTID bank_account.account_id
            builder.ACCTTYPE acct_type(bank_account.account_type)
            if bank_account.account_key != ""
              builder.ACCTKEY bank_account.account_key
            end
          end

          def self.acct_type(type)
            ACCT_TYPES.fetch(type)
          end
        end
      end

      register Banking::BankAccount, :"banking.bank_account"
    end
  end
end
