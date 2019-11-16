# frozen_string_literal: true

module Glabssms
  # This class is used as a response object when any of our calls to Globe Labs
  # fail
  class ErrorResult
    attr_reader :errors

    def initialize(errors)
      @errors = errors
    end

    def success?
      false
    end
  end
end
