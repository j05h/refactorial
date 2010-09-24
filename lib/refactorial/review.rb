module Refactorial
  class Review < Base

    def create data, private_gist = true, ext = nil, filename = nil
      url = ::Gist.write data, private_gist, ext, filename
      post url
    end

    def post url, id
      payload = encode( { :request_id => id, :review => { :url => url } } )
      decode site[users_resource].post payload, :content_type => :json
    end

    def users_resource
      "#{user_base}/#{resource}"
    end

    def resource
      "reviews.json"
    end

    def list
      response = configuration.site[users_resource].get
      decode response.body
    end

    def all
      response = configuration.site[resource].get
      decode response.body
    end
  end
end
