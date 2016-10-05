require "ofx/data/serialization"
require "ofx/data/serialization/common"

module OFX
  module Data
    module Serialization
      module Banking
        class Transaction
          extend Serialization::Common

          def self.serialize(transaction, builder)
            builder.STMTTRN do |builder|
              builder.TRNTYPE transaction.type.to_s.upcase
              builder.DTPOSTED transaction.date_posted.strftime("%Y%m%d%H%M%S")
              builder.TRNAMT transaction.amount.to_s("F")
              builder.FITID transaction.fitid
              if transaction.name
                builder.NAME transaction.name
              end
            end
          end
        end
      end

      register Banking::Transaction, :"banking.statement_transaction"
    end
  end
end
