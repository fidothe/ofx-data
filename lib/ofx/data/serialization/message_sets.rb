require "ofx/data/serialization/common"
require "ofx/data/serialization/message_sets/banking"

module OFX
  module Data
    module Serialization
      class MessageSets
        include Common

        def default_registry_entry_args
          [:message_sets, nil]
        end

        def serialize(message_sets, builder)
          serialize_collection(message_sets, builder)
        end
      end
    end
  end
end
