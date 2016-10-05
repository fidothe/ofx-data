require "ofx/data/serialization"
require "ofx/data/serialization/common"

module OFX
  module Data
    module Serialization
      module MessageSet
        module Banking
          class Request
          end

          class Response
            extend Serialization::Common

            def self.serialize(message_set, builder)
              builder.BANKMSGSRSV1 do |builder|
                serialize_collection(message_set.messages, builder)
              end
            end
          end
        end
      end

      register MessageSet::Banking::Response, :"message_sets.banking.response"
    end
  end
end
