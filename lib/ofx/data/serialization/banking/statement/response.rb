require "ofx/data/serialization"
require "ofx/data/serialization/common"

module OFX
  module Data
    module Serialization
      module Banking
        module Statement
          class Response
            extend Serialization::Common

            def self.serialize(response, builder)
              builder.STMTRS do |builder|
                builder.CURDEF response.curdef.to_s.upcase
                builder.BANKACCTFROM do |builder|
                  serialize_object(response.account, builder)
                end
                builder.BANKTRANLIST do |builder|
                  builder.DTSTART response.start_date.strftime("%Y%m%d%H%M%S")
                  builder.DTEND response.end_date.strftime("%Y%m%d%H%M%S")
                  serialize_collection(response.transactions, builder)
                end
                builder.LEDGERBAL do |builder|
                  serialize_object(response.ledger_balance, builder)
                end
                builder.AVAILBAL do |builder|
                  serialize_object(response.available_balance, builder)
                end
              end
            end
          end
        end
      end

      register Banking::Statement::Response, :"banking.statement.response"
    end
  end
end
