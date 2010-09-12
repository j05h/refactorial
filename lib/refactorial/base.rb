module Refactorial
  class Base
    def configuration
      Configure.instance
    end

    def site
      configuration.site
    end

    def github_user
      configuration.github_user
    end

    def logger
      configuration.logger
    end

    def user_base user = github_user
      "users/#{CGI::escape(user)}"
    end

    def encode object
      @encoder ||= Yajl::Encoder.new
      @encoder.encode object
    end

    def decode json
      @decoder ||= Yajl::Parser.new
      @decoder.parse json
    end

    def site
      configuration.site
    end
  end
end
