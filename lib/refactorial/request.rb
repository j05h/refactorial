module Refactorial
  class Request < Base
    # While we're in development, lets have all gists default to private
    def create data, private_gist = true,  ext = nil, filename = nil
      url = ::Gist.write data, private_gist, ext, filename
      post url
    end

    # We should probably be passing the filename along with the request instead of the language.
    # We should not rely on the client to tell us what language to code is, and instead intuit
    # that on the server side in hopes of better accuracy. Language here should be a suggestion.
    def post url, language = "Ruby"
      payload = encode( { :request => { :language => language, :url => url } } )
      decode site[resource].post payload, :content_type => :json
    end

    # This is only requests that the user made, but not requests that others have made.
    def list
      response = site[resource].get
      decode response.body
    end

    def all
      response = site['/requests.json'].get
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
