module Refactorial
  class Request < Base
    include Refactorial::Gist

    def create data
      puts '!' * 80
      puts ''
      super data
      send_request
      puts "Request created at #{self.url.green} " unless self.url.nil?
      puts ''
      puts '!' * 80
    end

    def send_request
        payload = ActiveSupport::JSON.encode( { :request => { :language => "Ruby", :url => self.url } } )
        configuration.site[users_resource].post payload, :content_type => :json
    end

    def users_resource
      "users/#{CGI::escape(github_user)}/requests.json"
    end

    def resource
      "requests.json"
    end

    def list
      response = configuration.site[resource].get
      ActiveSupport::JSON.decode response.body
    end

  end
end
