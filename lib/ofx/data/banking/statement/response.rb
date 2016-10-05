module OFX
  module Data
    module Banking
      module Statement
        class Response
          attr_reader :curdef, :account, :ledger_balance, :available_balance,
            :start_date, :end_date, :transactions, :marketing_info

          def initialize(opts)
            @curdef = opts.fetch(:curdef)
            @account = opts.fetch(:account)
            @ledger_balance = opts.fetch(:ledger_balance)
            @available_balance = opts.fetch(:available_balance)
            @start_date = opts.fetch(:start_date)
            @end_date = opts.fetch(:end_date)
            @transactions = opts.fetch(:transactions, [])
            @marketing_info = opts.fetch(:marketing_info, "")
          end

          def ofx_type
            :"banking.statement.response"
          end
        end
      end
    end
  end
end
