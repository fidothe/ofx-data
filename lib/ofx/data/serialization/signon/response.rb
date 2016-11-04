require "ofx/data/serialization/common"

module OFX
  module Data
    module Serialization
      module Signon
        class Response
          include Serialization::Common

          def default_registry_entry_args
            [:"signon.response", nil]
          end

          def serialize(response, builder)
            builder.SONRS do |builder|
              serialize_object(response.status, builder)
              builder.DTSERVER response.dtserver.strftime("%Y%m%d%H%M%S")
              builder.LANGUAGE response.language.to_s.upcase
            end
          end
        end
      end
    end
  end
end
