require "ofx/data/serialization"
require "ofx/data/serialization/common"

module OFX
  module Data
    module Serialization
      class MessageSets
        module Signon
          class Request
          end

          class Response
            include Serialization::Common

            def default_registry_entry_args
              [:"message_sets.signon.response", nil]
            end

            def serialize(message, builder)
              builder.SIGNONMSGSRSV1 do |builder|
                serialize_object(message.message, builder)
              end
            end
          end
        end
      end
    end
  end
end
