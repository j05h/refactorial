module Refactorial
  class Base
    def configuration
      Configure.instance
    end

    def github_user
      configuration.github_user
    end

    def logger
      configuration.logger
    end
  end
end
