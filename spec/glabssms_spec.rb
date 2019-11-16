# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Glabssms do
  describe '.configure' do
    it 'allows setting of app_id' do
      described_class.configure { |c| c.app_id = 'app_id' }
      expect(described_class.configuration.app_id).to eq 'app_id'
    end
    it 'allows setting of app_secret' do
      described_class.configure { |c| c.app_secret = 'app_secret' }
      expect(described_class.configuration.app_secret).to eq 'app_secret'
    end
    it 'allows setting of cross_telco_short_code' do
      described_class.configure { |c| c.cross_telco_short_code = '12345' }
      expect(described_class.configuration.cross_telco_short_code).to eq '12345'
    end
    it 'allows setting of short_code' do
      described_class.configure { |c| c.short_code = '12345' }
      expect(described_class.configuration.short_code).to eq '12345'
    end
    it 'allows setting of logger' do
      logger = Logger.new('tmp/log.log')
      described_class.configure { |c| c.logger = logger }
      expect(described_class.configuration.logger).to eq logger
    end
  end
end
