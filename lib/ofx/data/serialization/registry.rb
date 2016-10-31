require "ofx/data/serialization/registry/entry"

module OFX
  module Data
    module Serialization
      class Registry
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

      class OldRegistry
        def initialize
          @registry = {}
        end

        def register(serialization_class, ofx_type)
          @registry[ofx_type] = serialization_class
        end

        def serializer_for(data_instance)
          @registry.fetch(data_instance.ofx_type)
        end

        def registered_for(serialization_class)
          @registry.find(->() { [] }) { |ofx_type, klass| klass == serialization_class }.first
        end
      end

      def self.registry
        @registry ||= OFX::Data::Serialization::OldRegistry.new
      end

      def self.register(*args)
        registry.register(*args)
      end
    end
  end
end
