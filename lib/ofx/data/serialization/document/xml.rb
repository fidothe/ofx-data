require "ofx/data/serialization"
require "ofx/data/serialization/common"

module OFX
  module Data
    module Serialization
      module Document
        class XML
          include Common

          def self.register_with(registry)
            serializer = new(registry)
            registry.register(serializer.registry_entry)
          end

          attr_reader :registry

          def initialize(registry)
            @registry = registry
          end

          def default_registry_entry_args
            [:document, nil]
          end

          def registry_entry
            Registry::Entry.new(self, *default_registry_entry_args)
          end

          def serialize(document, builder)
            decl = document.declaration
            builder.instruct!
            builder.instruct!(:OFX, {
              OFXHEADER: decl.ofxheader,
              VERSION: decl.version,
              SECURITY: decl.security,
              OLDFILEUID: decl.oldfileuid,
              NEWFILEUID: decl.newfileuid
            })
            builder.OFX do |builder|
              serialize_object(document.message_sets, builder)
            end
          end
        end
      end
    end
  end
end
