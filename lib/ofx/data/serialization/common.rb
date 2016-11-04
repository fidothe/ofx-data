require "ofx/data/serialization/registry"

module OFX
  module Data
    module Serialization
      module Common
        module ClassMethods
          def register_with(registry)
            serializer = new(registry)
            registry.register(serializer.registry_entry)
          end
        end

        def self.included(base)
          base.extend ClassMethods
          base.class_eval do
            attr_reader :registry
          end
        end

        def initialize(registry)
          @registry = registry
        end

        def default_registry_entry_args
          raise NotImplementedError, "must be implemented in includer"
        end

        def registry_entry
          Registry::Entry.new(self, *default_registry_entry_args)
        end

        def serialize_object(object, builder)
          registry.serializer_for(object.ofx_type).serialize(object, builder)
        end

        def serialize_collection(collection, builder)
          collection.each do |object|
            serialize_object(object, builder)
          end
        end
      end
    end
  end
end
