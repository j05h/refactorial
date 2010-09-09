module Refactorial
  module Review < Base
    def resource
      "users/#{CGI::escape(github_user)}/reviews.json"
    end

    def list
      response = configuration.site[resource].get
      ActiveSupport::JSON.decode response.body
    end
  end
end
