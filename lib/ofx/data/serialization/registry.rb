module OFX
  module Data
    module Serialization
      class Registry
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
        @registry ||= OFX::Data::Serialization::Registry.new
      end

      def self.register(*args)
        registry.register(*args)
      end
    end
  end
end
