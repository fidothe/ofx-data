require "ofx/data/serialization/registry/entry"

module OFX
  module Data
    module Serialization
      class Registry
        def self.build(&block)
          registry = new
          block.call(registry)
          registry
        end

        attr_reader :entries

        def initialize
          @entries = []
        end

        def register(entry)
          entries << entry
        end

        def matching_entry(ofx_type, context_name)
          match = entries.find { |entry| entry.match?(ofx_type, context_name) }
          raise SerializerNotFoundError.generate(ofx_type, context_name) if match.nil?
          match
        end

        def serializer_for(ofx_type, context_name = nil)
          matching_entry(ofx_type, context_name).serializer
        end
      end

      class SerializerNotFoundError < StandardError
        def self.generate(ofx_type, context_name)
          message = "Cannot find serializer for OFX type #{ofx_type.inspect}"
          message << " with context name #{context_name.inspect}" if context_name
          new(message)
        end
      end
    end
  end
end
