module OFX
  module Data
    class MessageSets
      module Banking
        MESSAGE_SET_TYPE = :banking

        class Request
          def message_set_type
            MESSAGE_SET_TYPE
          end
        end

        class Response
          attr_reader :messages

          def initialize(messages)
            @messages = messages
          end

          def message_set_type
            MESSAGE_SET_TYPE
          end

          def ofx_type
            :"message_sets.banking.response"
          end
        end
      end
    end
  end
end
