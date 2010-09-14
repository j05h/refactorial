module Refactorial
  class Review < Base
    include Refactorial::Gist

    def create data
      puts '!' * 80
      puts ''
      super data
      send_request
      puts "Review created at #{self.url.strip.green} " unless self.url.nil?
      puts ''
      puts '!' * 80
    end

    def send_request
        payload = ActiveSupport::JSON.encode( { :request => { :url => self.url } } )
        configuration.site[users_resource].post payload, :content_type => :json
    end

    def users_resource
      "users/#{CGI::escape(github_user)}/reviews.json"
    end

    def resource
      "reviews.json"
    end

    def list
      response = configuration.site[users_resource].get
      ActiveSupport::JSON.decode response.body
    end
  end
end
