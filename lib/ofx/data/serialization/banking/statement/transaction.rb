require "ofx/data/serialization"
require "ofx/data/serialization/common"

module OFX
  module Data
    module Serialization
      module Banking
        module Statement
          module Transaction
            class Response
              extend Common

              def self.serialize(transaction, builder)
                builder.STMTTRNRS do |builder|
                  builder.TRNUID transaction.trnuid
                  serialize_collection(children(transaction), builder)
                end
              end

              def self.children(transaction)
                [transaction.status, transaction.response]
              end
            end
          end
        end
      end

      register Banking::Statement::Transaction::Response, :"banking.statement.transaction.response"
    end
  end
end
