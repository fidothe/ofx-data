require "date"
require "bigdecimal"

module OFX
  module Data
    module Banking
      class Balance
        attr_reader :amount, :date

        def initialize(opts)
          @amount = BigDecimal.new(opts.fetch(:amount))
          @date = opts.fetch(:date)
        end

        def ofx_type
          :"banking.balance"
        end
      end
    end
  end
end
