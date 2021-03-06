require "ofx/data/declaration"

module OFX
  module Data
    class Document
      attr_reader :message_sets, :declaration

      def initialize(opts = {})
        @message_sets = opts.fetch(:message_sets)
        @declaration = opts.fetch(:declaration, Declaration.default)
      end

      def response?
        true
      end

      def request?
        !response?
      end

      def ofx_type
        :document
      end
    end
  end
end
