require "ofx/data/message_sets/signon"
require "ofx/data/message_sets/banking"

module OFX
  module Data
    class MessageSets
      ORDER = [
        :signon, :signup, :banking, :credit_card_statements,
        :investment_statements, :interbank_funds_transfers,
        :wire_funds_transfers, :payments, :general_email,
        :investment_security_list, :biller_directory,
        :bill_delivery, :fi_profile
      ]
      ORDER_LOOKUP = Hash[ORDER.each_with_index.map { |k, v| [k, v] }]

      def initialize(message_sets)
        @message_sets = message_sets
      end

      def ofx_type
        :message_sets
      end

      def ordered_sets
        @message_sets.sort_by { |set| ORDER_LOOKUP[set.message_set_type] }
      end

      def each(&block)
        ordered_sets.each(&block)
      end
    end
  end
end
