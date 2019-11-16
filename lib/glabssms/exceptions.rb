module Glabssms
  class GlabssmsError < ::StandardError; end
  class ConfigurationError < GlabssmsError; end
  class UnexpectedError < GlabssmsError; end
end
