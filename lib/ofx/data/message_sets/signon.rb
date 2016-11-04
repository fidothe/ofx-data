module OFX
  module Data
    class MessageSets
      module Signon
        MESSAGE_SET_TYPE = :signon

        class Request
          def message_set_type
            MESSAGE_SET_TYPE
          end
        end

        class Response
          attr_reader :message

          def initialize(message)
            @message = message
          end

          def message_set_type
            MESSAGE_SET_TYPE
          end

          def ofx_type
            :"message_sets.signon.response"
          end
        end
      end
    end
  end
end
