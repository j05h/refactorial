module Refactorial
  # The Setup class will configure the refactorial gem
  # so that you can start sending request and reviewing code
  class Setup < Base
    # This will determine if the user has both a
    # github account and a refactorial account
    #
    # @example
    #
    #   setup = Setup.new
    #   setup.authenticated?
    #   # => true
    #
    # @return boolean
    def authenticated?
      refactorial_account? and github_account?
    end

    # In order to have a valid github account
    # both the user and API token must be setup
    #
    # @return boolean
    def github_account?
      !github_user.nil? and !github_token.nil?
    end

    # Gets the github user.
    #
    # @return github username
    def github_user
      @user ||= `git config --get github.user`.strip
      @user ||= ENV[:GITHUB_USER].strip
    end

    # Gets the github API token for this user
    #
    # @return the github API token
    def github_token
      @token ||= `git config --get github.token`.strip
      @token ||= ENV[:GITHUB_TOKEN].strip
    end

    # Is the refactorial account setup
    #
    # @return boolean
    def refactorial_account?
      # Search for this account name
      true
    end

    # Create a refactorial account
    #
    # @return json details
    def create_refactorial_account
      payload = ActiveSupport::JSON.encode( { :user => { :github_account => github_user } } )
      puts configuration.site['users.json'].post payload, :content_type => :json
    end
  end
end
