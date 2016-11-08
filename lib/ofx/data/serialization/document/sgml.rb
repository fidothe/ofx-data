require "ofx/data/serialization/common"

module OFX
  module Data
    module Serialization
      module Document
        class SGML
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
            write_headers(builder, document.declaration)
            builder.OFX do |builder|
              serialize_object(document.message_sets, builder)
            end
          end

          private

          def write_headers(builder, declaration)
            {
              OFXHEADER: declaration.ofxheader,
              DATA: "OFXSGML",
              VERSION: declaration.version,
              SECURITY: declaration.security,
              ENCODING: encoding(declaration),
              CHARSET: charset(declaration),
              COMPRESSION: "NONE",
              OLDFILEUID: declaration.oldfileuid,
              NEWFILEUID: declaration.newfileuid
            }.each do |name, value|
              write_header(builder, name, value)
            end
            builder << "\r\n"
          end

          def write_header(builder, name, value)
            builder << "#{name}:#{value}\r\n"
          end

          def encoding(declaration)
            case Encoding.find(declaration.encoding)
            when Encoding::UTF_8
              "UTF-8"
            else
              "USASCII"
            end
          end

          def charset(declaration)
            case Encoding.find(declaration.encoding)
            when Encoding::UTF_8
              "NONE"
            when Encoding::Windows_1252
              "1252"
            when Encoding::ISO_8859_1
              "ISO-8859-1"
            else
              raise ArgumentError, "Declaration encoding (#{declaration.encoding}) is not one of (or equivalent to) UTF-8, ISO-8859-1, or Windows-1252"
            end
          end
        end
      end
    end
  end
end
