module Refactorial
  class Request < Base
    # While we're in development, lets have all gists default to private
    def create data, private_gist = true,  ext = nil, filename = nil
      url = ::Gist.write data, private_gist, ext, filename
      post url
    end

    def post url, language = "Ruby"
      payload = encode( { :request => { :language => language, :url => url } } )
      decode site[resource].post payload, :content_type => :json
    end

    def list
      response = site[resource].get
      decode response.body
    end

    def resource
      "users/#{CGI::escape(github_user)}/requests.json"
    end

    private
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
