require "ofx/data/serialization"
require "ofx/data/serialization/common"

module OFX
  module Data
    module Serialization
      class Document
        extend Common

        def self.serialize(document, builder)
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
            MessageSet.serialize(document.message_sets, builder)
          end
        end
      end

      register(Document, :document)
    end
  end
end
