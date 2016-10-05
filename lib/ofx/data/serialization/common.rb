module OFX
  module Data
    module Serialization
      module Common
        def serialize_object(object, builder)
          registry.serializer_for(object).serialize(object, builder)
        end

        def serialize_collection(collection, builder)
          collection.each do |object|
            serialize_object(object, builder)
          end
        end

        def registry
          OFX::Data::Serialization.registry
        end
      end
    end
  end
end
