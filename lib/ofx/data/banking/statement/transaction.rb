module OFX
  module Data
    module Banking
      module Statement
        module Transaction
          class Response
            attr_reader :trnuid, :status, :response

            def initialize(opts)
              @trnuid = opts.fetch(:trnuid)
              @status = opts.fetch(:status)
              @response = opts.fetch(:response)
            end

            def ofx_type
              :"banking.statement.transaction.response"
            end
          end
        end
      end
    end
  end
end
