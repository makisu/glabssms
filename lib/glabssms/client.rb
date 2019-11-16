module Glabssms
  class Client
    attr_reader :config

    def initialize(config)
      if config.is_a? Hash
        @config = Configuration.new config
      elsif config.is_a? Glabssms::Configuration
        @config = config
      else
        raise ArgumentError, 'config is an invalid type'
      end
    end

    def get_token(code:)
      uri = URI.parse("https://developer.globelabs.com.ph/oauth/access_token?app_id=#{config.app_id}&app_secret=#{config.app_secret}&code=#{code}")
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      req = Net::HTTP::Post.new(uri.request_uri)
      res = https.request(req)
      body = JSON.parse(res.body).with_indifferent_access

      if body[:access_token] && body[:subscriber_number]
        TokenResult._new(body)
      elsif body[:error]
        ErrorResult.new(body[:error])
      else
        raise UnexpectedError, 'expected query parameters app_id, app_secret and code'
      end
    end

    def send_sms(number:, message:, token:)
      header = { 'Content-Type': 'application/json' }
      sender_address = config.short_code[-4..-1]
      sms_params = {
        outboundSMSMessageRequest: {
          senderAddress: sender_address,
          outboundSMSTextMessage: { message: message },
          address: number
        }
      }.to_json

      uri = URI.parse("https://devapi.globelabs.com.ph/smsmessaging/v1/outbound/#{sender_address}/requests?access_token=#{token}")
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      req = Net::HTTP::Post.new(uri.request_uri, header)
      req.body = sms_params
      res = https.request(req)

      body = JSON.parse(res.body).with_indifferent_access

      if body['outboundSMSMessageRequest']
        SmsResult._new(body)
      elsif body[:error]
        ErrorResult.new(body[:error])
      else
        raise UnexpectedError, 'expected query parameters access_token'
      end
    end
  end
end
