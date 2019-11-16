module Glabssms
  class Configuration
    READABLE_ATTRIBUTES = %i[app_id app_secret cross_telco_short_code short_code]

    WRITABLE_ATTRIBUTES = %i[app_id app_secret cross_telco_short_code short_code logger]

    class << self
      attr_writer *WRITABLE_ATTRIBUTES
    end
    attr_reader *READABLE_ATTRIBUTES
    attr_writer *WRITABLE_ATTRIBUTES

    def self.expectant_reader(*attributes)
      attributes.each do |attribute|
        (
          class << self
            self
          end
        )
          .send(:define_method, attribute) do
          attribute_value = instance_variable_get("@#{attribute}")
          if attribute_value.nil? || attribute_value.to_s.empty?
            raise ConfigurationError.new(
              "Glabssms::Configuration.#{attribute} needs to be set"
            )
          end
          attribute_value
        end
      end
    end
    expectant_reader *READABLE_ATTRIBUTES

    def self.client
      Glabssms::Client.new(instantiate)
    end

    def self.instantiate
      config = new
    end

    def self.logger
      @logger ||= _default_logger
    end

    def initialize(options = {})
      WRITABLE_ATTRIBUTES.each do |attr|
        instance_variable_set "@#{attr}",
          options[attr] || Glabssms.configuration.send(attr)
      end
    end

    def logger
      @logger ||= self.class._default_logger
    end

    def self._default_logger
      logger = Logger.new(STDOUT)
      logger.level = Logger::INFO
      logger
    end

    def inspect
      super.gsub(/@app_secret=\".*\"/, '@app_secret="[FILTERED]"')
    end

    def assert_has_keys
      if app_id.nil? || app_secret.nil? || cross_telco_short_code.nil? || short_code.nil?
        raise ConfigurationError.new(
          'Glabssms::Configuration app_id, app_secret, cross_telco_short_code, short_code and are required.'
        )
      end
    end
  end
end
