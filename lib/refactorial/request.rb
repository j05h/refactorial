module Refactorial
  class Request < Base
    include Refactorial::Gist

    def create data
      puts '!' * 80
      puts ''
      super data
      send_request
      puts "Review created at #{self.url.green} " unless self.url.nil?
      puts ''
      puts '!' * 80
    end

    def gist_to_js
      self.url + '.js'
    end

    def send_request
        payload = ActiveSupport::JSON.encode( { :request => { :language => "Ruby", :url => self.url } } )
        configuration.site[resource].post payload, :content_type => :json
    end

    def github_user
      configuration.github_user
    end

    def resource
      "users/#{CGI::escape(github_user)}/requests.json"
    end

    def list
      response = configuration.site[resource].get
      ActiveSupport::JSON.decode response.body
    end

  end
end
