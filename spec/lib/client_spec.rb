# frozen_string_literal: true

require 'spec_helper'

module Glabssms
  RSpec.describe Client, vcr: { record: :once, match_requests_on: %i[:uri :method] } do
    describe '.new' do
      before do
        Glabssms.configure do |c|
          c.app_id = 'app_id'
          c.app_secret = 'app_secret'
          c.cross_telco_short_code = '12345'
          c.short_code = '12345'
        end
      end
      it 'initializes with default config' do
        client = described_class.new(Glabssms::Configuration.new)
        expect(client).to be_a Glabssms::Client
      end
      it 'initializes with overriden config' do
        client = described_class.new(
          app_id: 'some_app_id',
          app_secret: CONFIG[:app_secret],
          logger: Logger.new('tmp/test.log')
        )
        expect(client).to be_a Glabssms::Client
      end
    end

    describe '#get_token' do
      Glabssms.configure do |c|
        c.app_id = CONFIG[:app_id]
        c.app_secret = CONFIG[:app_secret]
        c.cross_telco_short_code = CONFIG[:cross_telco_short_code]
        c.short_code = CONFIG[:short_code]
      end
      it 'returns a TokenResult' do
        code = CONFIG[:code]

        client = described_class.new(Glabssms::Configuration.new)
        result = client.get_token(code: code)
        expect(result).to be_a TokenResult
      end
      it 'returns an ErrorResult' do
        code = 'invalid_code'

        client = described_class.new(Glabssms::Configuration.new)
        result = client.get_token(code: code)
        expect(result).to be_an ErrorResult
      end
    end

    describe '#send_sms' do
      Glabssms.configure do |c|
        c.app_id = CONFIG[:app_id]
        c.app_secret = CONFIG[:app_secret]
        c.cross_telco_short_code = CONFIG[:cross_telco_short_code]
        c.short_code = CONFIG[:short_code]
      end
      it 'returns an SmsResult' do
        number = '09171234567'
        message = 'This is a test'
        token = CONFIG[:access_token]

        client = described_class.new(Glabssms::Configuration.new)
        result = client.send_sms(number: number, message: message, token: token)
        expect(result).to be_an SmsResult
      end
      it 'returns an ErrorResult' do
        number = '09171234567'
        message = 'This is a test'
        token = 'invalid_token'

        client = described_class.new(Glabssms::Configuration.new)
        result = client.send_sms(number: number, message: message, token: token)
        expect(result).to be_an ErrorResult
      end
    end
  end
end
