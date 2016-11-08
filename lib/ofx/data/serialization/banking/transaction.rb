require "ofx/data/serialization/common"

module OFX
  module Data
    module Serialization
      module Banking
        class Transaction
          include Serialization::Common

          def default_registry_entry_args
            [:"banking.statement_transaction", nil]
          end


          def serialize(transaction, builder)
            builder.STMTTRN do |builder|
              builder.TRNTYPE transaction.type.to_s.upcase
              builder.DTPOSTED transaction.date_posted.strftime("%Y%m%d%H%M%S")
              builder.TRNAMT transaction.amount.to_s("F")
              builder.FITID transaction.fitid
              if transaction.name
                builder.NAME transaction.name
              end
              if transaction.memo
                builder.MEMO transaction.memo
              end
            end
          end
        end
      end
    end
  end
end
