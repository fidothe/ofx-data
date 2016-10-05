module OFX
  module Data
    module Transaction
      class Status
        SEVERITIES = [:info, :warn, :error].freeze

        attr_reader :code, :severity, :message

        def initialize(opts)
          @code = opts.fetch(:code)
          raise ArgumentError, ":code must be an integer, was #{@code.inspect}" unless @code.is_a?(Fixnum)
          raise ArgumentError, ":code must be a positive integer < 1000000, was #{@code}" if @code > 999999
          @severity = opts.fetch(:severity)
          raise ArgumentError, ":severity must be one of #{SEVERITIES.inspect}, was #{@severity.inspect}" unless SEVERITIES.include?(@severity)
          @message = opts.fetch(:message, nil)
          raise ArgumentError, ":message must be no more than 255 chars, was #{@message.length}" if @message && @message.length > 255
        end

        def ofx_type
          :"transaction.status"
        end
      end
    end
  end
end
