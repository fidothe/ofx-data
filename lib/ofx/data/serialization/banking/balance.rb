require "ofx/data/serialization/common"

module OFX
  module Data
    module Serialization
      module Banking
        class Balance
          include Serialization::Common

          def default_registry_entry_args
            [:"banking.balance", nil]
          end

          def serialize(balance, builder)
            builder.BALAMT balance.amount.to_s("F")
            builder.DTASOF balance.date.strftime("%Y%m%d%H%M%S")
          end
        end
      end
    end
  end
end
