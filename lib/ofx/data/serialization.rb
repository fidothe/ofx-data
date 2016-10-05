require "ofx/data/serialization/registry"
require "ofx/data/serialization/document"
require "ofx/data/serialization/message_set"
require "ofx/data/serialization/banking"
require "ofx/data/serialization/transaction/status"

module OFX
  module Data
    module Serialization
      def self.serialize(object)
        xml = Builder::XmlMarkup.new
        registry.serializer_for(object).serialize(object, xml)
        xml.target!
      end
    end
  end
end
