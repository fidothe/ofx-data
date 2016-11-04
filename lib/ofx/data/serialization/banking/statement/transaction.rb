require "ofx/data/serialization/common"

module OFX
  module Data
    module Serialization
      module Banking
        module Statement
          module Transaction
            class Response
              include Common

              def default_registry_entry_args
                [:"banking.statement.transaction.response", nil]
              end

              def serialize(transaction, builder)
                builder.STMTTRNRS do |builder|
                  builder.TRNUID transaction.trnuid
                  serialize_collection(children(transaction), builder)
                end
              end

              def children(transaction)
                [transaction.status, transaction.response]
              end
            end
          end
        end
      end
    end
  end
end
