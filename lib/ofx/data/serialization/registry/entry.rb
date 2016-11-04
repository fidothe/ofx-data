module OFX
  module Data
    module Serialization
      class Registry
        class Entry
          attr_reader :serializer, :ofx_type, :context_name

          def initialize(serializer, ofx_type, context_name = nil)
            @serializer = serializer
            @ofx_type = ofx_type
            @context_name = context_name
          end

          def match?(ofx_type, context_name = nil)
            self.ofx_type == ofx_type && self.context_name == context_name
          end
        end
      end
    end
  end
end
