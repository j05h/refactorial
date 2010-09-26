module Refactorial
  # The Setup class will configure the refactorial gem
  # so that you can start sending request and reviewing code
  class Setup < Base
    # This will determine if the user has both a
    # github account and a refactorial account
    #
    # Example
    #
    #   setup = Setup.new
    #   setup.authenticated?
    #   # => true
    #
    # Return boolean
    def authenticated?
      refactorial_account? and github_account?
    end

    # In order to have a valid github account
    # both the user and API token must be setup
    #
    # Return boolean
    def github_account?
      !github_user.nil? and !github_token.nil?
    end

    # Gets the github API token for this user
    #
    # Return the github API token
    def github_token
      @token ||= `git config --get github.token`.strip
      @token ||= ENV[:GITHUB_TOKEN].strip
    end

    # Is the refactorial account setup
    #
    # Return boolean
    def refactorial_account?
      # Search for this account name
      !get_account.nil?
    end

    def get_account
      response = site["users/#{CGI::escape(github_user)}.json"].get
      decode response unless response == 'null'
    end

    # Create a refactorial account
    def create_account
      unless authenticated?
        payload = encode( { :user => { :github_account => github_user } } )
        response = site['users.json'].post payload, :content_type => :json
        !response.nil?
      end
    end
  end
end
