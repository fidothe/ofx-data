require "ofx/data/serialization"
require "ofx/data/serialization/common"

module OFX
  module Data
    module Serialization
      class MessageSets
        module Banking
          class Request
          end

          class Response
            include Serialization::Common

            def default_registry_entry_args
              [:"message_sets.banking.response", nil]
            end

            def serialize(message_set, builder)
              builder.BANKMSGSRSV1 do |builder|
                serialize_collection(message_set.messages, builder)
              end
            end
          end
        end
      end
    end
  end
end
