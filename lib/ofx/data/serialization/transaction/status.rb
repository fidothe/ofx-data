require "ofx/data/serialization"
require "ofx/data/serialization/common"

module OFX
  module Data
    module Serialization
      module Transaction
        class Status
          extend Serialization::Common

          def self.serialize(status, builder)
            builder.STATUS do |builder|
              builder.CODE status.code
              builder.SEVERITY status.severity.to_s.upcase
              unless status.message.nil?
                builder.MESSAGE status.message
              end
            end
          end
        end
      end

      register Transaction::Status, :"transaction.status"
    end
  end
end
