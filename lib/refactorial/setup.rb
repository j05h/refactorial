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
      !get_account.nil?
    end

    def get_account
      response = configuration.site["users/#{CGI::escape(github_user)}.json"].get
      decode response.body
    end

    # Create a refactorial account
    def create_account
      unless authenticated?
        payload = encode( { :user => { :github_account => github_user } } )
        response = configuration.site['users.json'].post payload, :content_type => :json
        !response.nil?
      end
    end
  end
end
