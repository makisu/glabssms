module Glabssms
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
