require "ofx/data/serialization"
require "ofx/data/serialization/common"
require "ofx/data/serialization/message_set/banking"

module OFX
  module Data
    module Serialization
      module MessageSet
        extend Common

        ORDER = [
          :signon, :signup, :banking, :credit_card_statements,
          :investment_statements, :interbank_funds_transfers,
          :wire_funds_transfers, :payments, :general_email,
          :investment_security_list, :biller_directory,
          :bill_delivery, :fi_profile
        ]
        ORDER_LOOKUP = Hash[ORDER.each_with_index.map { |k, v| [k, v] }]

        def self.order_sets(message_sets)
          message_sets.sort_by { |set| ORDER_LOOKUP[set.message_set_type] }
        end

        def self.serialize(message_sets, builder)
          serialize_collection(order_sets(message_sets), builder)
        end
      end

      register(MessageSet, :message_sets)
    end
  end
end
