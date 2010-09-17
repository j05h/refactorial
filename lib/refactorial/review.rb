module Refactorial
  class Review < Base
    include Refactorial::Gist

    def create data
      super data
      send_request
    end

    def send_request
        payload = ActiveSupport::JSON.encode( { :request => { :url => self.url } } )
        configuration.site[users_resource].post payload, :content_type => :json
    end

    def users_resource
      "users/#{CGI::escape(github_user)}/#{resource}"
    end

    def resource
      "reviews.json"
    end

    def list
      response = configuration.site[resource].get
      ActiveSupport::JSON.decode response.body
    end
  end
end
