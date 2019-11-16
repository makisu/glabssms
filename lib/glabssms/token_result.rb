# frozen_string_literal: true

module Glabssms
  # This class is used as a response object when we successfully retrieve a
  # token from Globe Labs
  class TokenResult
    include BaseModule

    attr_reader :access_token
    attr_reader :subscriber_number

    def initialize(attributes)
      set_instance_variables_from_hash(attributes)
    end

    class << self
      protected :new
      def _new(*args)
        new(*args)
      end
    end

    def success?
      true
    end
  end
end
