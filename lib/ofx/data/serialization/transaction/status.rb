require "ofx/data/serialization"
require "ofx/data/serialization/common"

module OFX
  module Data
    module Serialization
      module Transaction
        class Status
          include Serialization::Common

          def default_registry_entry_args
            [:"transaction.status", nil]
          end

          def serialize(status, builder)
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
    end
  end
end
