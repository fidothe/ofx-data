module OFX
  module Data
    module Signon
      class Response
        attr_reader :status, :dtserver, :language

        def initialize(opts)
          @status = opts.fetch(:status)
          @dtserver = opts.fetch(:dtserver)
          @language = opts.fetch(:language)
        end

        def ofx_type
          :"signon.response"
        end
      end
    end
  end
end
