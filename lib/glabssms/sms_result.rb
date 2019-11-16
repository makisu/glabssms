module Glabssms
  class SmsResult
    include BaseModule

    attr_reader :number
    attr_reader :sender_address
    attr_reader :message

    def initialize(attributes)
      message_request = attributes.dig('outboundSMSMessageRequest')
      @number = message_request.dig('address')
      @sender_address = message_request.dig('senderAddress')
      @message = message_request.dig('outboundSMSTextMessage', 'message')
    end

    class << self
      protected :new
      def _new(*args)
        self.new(*args)
      end
    end

    def success?
      true
    end
  end
end
