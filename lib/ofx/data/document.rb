require "ofx/data/declaration"

module OFX
  module Data
    class Document
      attr_reader :message_sets, :declaration

      def initialize(opts = {})
        @message_sets = opts.fetch(:message_sets, []).freeze
        @declaration = opts.fetch(:declaration, Declaration.default)
      end

      def response?
        true
      end

      def request?
        !response?
      end
    end
  end
end
