require "builder"
require "ofx/data/serialization/registry"
require "ofx/data/serialization"

module OFX
  module Data
    module Serialization
      module OFX203
        SERIALIZER_CLASSES = [
          Document, Transaction::Status,
          MessageSets, MessageSets::Banking::Response,
          MessageSets::Signon::Response, Signon::Response,
          Banking::Balance, Banking::BankAccount,
          Banking::Transaction, Banking::Statement::Response,
          Banking::Statement::Transaction::Response
        ]

        def self.registry
          Registry.build { |r|
            SERIALIZER_CLASSES.each do |klass|
              klass.register_with(r)
            end
          }
        end

        def self.builder
          Builder::XmlMarkup.new
        end

        def self.serialize(object)
          output = builder
          registry.serializer_for(object.ofx_type).serialize(object, output)
          output.target!
        end
      end
    end
  end
end
