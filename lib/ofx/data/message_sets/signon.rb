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
          def message_set_type
            MESSAGE_SET_TYPE
          end
        end
      end
    end
  end
end
