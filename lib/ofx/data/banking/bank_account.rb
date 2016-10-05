module OFX
  module Data
    module Banking
      class BankAccount
        VALID_TYPES = [:checking, :savings, :money_market, :credit_line]
        attr_reader :bank_id, :branch_id, :account_id, :account_type, :account_key

        def initialize(opts)
          @bank_id = opts.fetch(:bank_id)
          raise ArgumentError, ":bank_id must be 1-9 characters long" if @bank_id.length > 9
          @branch_id = opts.fetch(:branch_id, "")
          raise ArgumentError, ":branch_id must be 1-22 characters long" if @branch_id.length > 22
          @account_id = opts.fetch(:account_id)
          raise ArgumentError, ":account_id must be 1-22 characters long" if @account_id.length > 22
          @account_type = opts.fetch(:account_type)
          raise ArgumentError, ":account_type must be one of #{VALID_TYPES.inspect}, it was #{@account_type.inspect}" if !VALID_TYPES.include?(@account_type)
          @account_key = opts.fetch(:account_key, "")
          raise ArgumentError, ":account_key must be 1-22 characters long" if @account_key.length > 22
        end

        def fitid_str
          [
            :bank_id, :branch_id, :account_id, :account_type, :account_key
          ].map { |meth|
            send(meth)
          }.join("")
        end

        def ofx_type
          :"banking.bank_account"
        end
      end
    end
  end
end
