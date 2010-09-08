module Refactorial
  class Base
    def configuration
      Configure.instance
    end

    def logger
      configuration.logger
    end
  end
end
