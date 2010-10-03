module Refactorial
  class Base
    # Configuration instance
    # contains all configuration for this run
    #
    # Returns instance of the configuration
    def configuration
      Configure.instance
    end

    # Base Site
    #
    # Returns RestClient Base site
    def site
      configuration.site
    end

    # Github user configured on this system
    #
    # Returns string
    def github_user
      configuration.github_user
    end

    # Instance of the logger
    #
    # Returns logger
    def logger
      configuration.logger
    end

    # Base url for users
    #
    # Returns string
    def user_base user = github_user
      "users/#{CGI::escape(user)}"
    end

    # JOSN encode object
    #
    # Returs json
    def encode object
      @encoder ||= Yajl::Encoder.new
      @encoder.encode object
    end

    # JOSN decode object
    #
    # Returs object
    def decode json
      Yajl::Parser.parse json
    end
  end
end
