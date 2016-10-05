require "ofx/data/serialization"
require "ofx/data/serialization/common"

module OFX
  module Data
    module Serialization
      module Banking
        class Balance
          extend Serialization::Common

          def self.serialize(balance, builder)
            builder.BALAMT balance.amount.to_s("F")
            builder.DTASOF balance.date.strftime("%Y%m%d%H%M%S")
          end
        end
      end

      register Banking::Balance, :"banking.balance"
    end
  end
end
