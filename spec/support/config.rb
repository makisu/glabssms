config = YAML.load_file(SPEC_DIR.join('config.yml')).with_indifferent_access
if app_id = ENV['GLABS_APP_ID'].presence
  config[:app_id] = app_id
end
if app_secret = ENV['GLABS_APP_SECRET'].presence
  config[:app_secret] = app_secret
end
if cross_telco_short_code = ENV['GLABS_CROSS_TELCO_SHORT_CODE'].presence
  config[:cross_telco_short_code] = cross_telco_short_code
end
if short_code = ENV['GLABS_APP_SHORT_CODE'].presence
  config[:short_code] = short_code
end
CONFIG = config
