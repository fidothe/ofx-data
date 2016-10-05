require "bigdecimal"
require "digest/sha1"

module OFX
  module Data
    module Banking
      class Transaction
        FIELDS = [:type, :date_posted, :amount, :bank_account_to, :name, :refnum, :payee_id, :memo].freeze
        VALID_TYPES = [
          :credit, :debit, :int, :div, :fee, :srvchg, :dep, :atm, :pos, :xfer,
          :check, :payment, :cash, :directdep, :directdebit, :repeatpmt, :other
        ].freeze

        def self.with_synthetic_fitid(opts)
          input = FIELDS.map { |key|
            opts.fetch(key, "")
          }.map { |value|
            value.respond_to?(:fitid_str) ? value.fitid_str : value.to_s
          }.join("")
          fitid = Digest::SHA1.hexdigest(input)
          new(opts.merge(fitid: fitid))
        end

        attr_reader :fitid, *FIELDS

        def initialize(opts)
          @type = opts.fetch(:type)
          raise ArgumentError, ":type must be one of #{VALID_TYPES.inspect}, was #{@type}" if !VALID_TYPES.include?(@type)
          @date_posted = opts.fetch(:date_posted)
          @amount = BigDecimal.new(opts.fetch(:amount))
          @fitid = opts.fetch(:fitid)
          @bank_account_to = opts.fetch(:bank_account_to, nil)
          @name = opts.fetch(:name, nil)
          raise ArgumentError, ":name must be 1-32 characters long" if @name && @name.length > 32
          @refnum = opts.fetch(:refnum, nil)
          raise ArgumentError, ":refnum must be 1-32 characters long" if @refnum && @refnum.length > 32
          @payee_id = opts.fetch(:payee_id, nil)
          raise ArgumentError, ":payee_id must be 1-12 characters long" if @payee_id && @payee_id.length > 12
          @memo = opts.fetch(:memo, nil)
        end

        def ofx_type
          :"banking.statement_transaction"
        end
      end
    end
  end
end
