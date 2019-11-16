require 'gem_config'
require 'glabssms/version'
require 'net/http'
require 'net/https'
require 'json'
require 'glabssms/base_module'
require 'glabssms/configuration'
require 'glabssms/exceptions'
require 'glabssms/client'
require 'glabssms/token_result'
require 'glabssms/sms_result'
require 'glabssms/error_result'

module Glabssms
  include GemConfig::Base

  with_configuration do
    has :app_id, classes: String
    has :app_secret, classes: String
    has :cross_telco_short_code, classes: String
    has :short_code, classes: String
    has :logger
  end
end
