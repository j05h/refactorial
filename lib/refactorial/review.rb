module Refactorial
  class Review < Base

    def create data, review_id, private_gist = true, ext = nil, filename = nil
      url = ::Gist.write data, private_gist, ext, filename
      post url, review_id
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
      response = site[users_resource].get
      decode response.body
    end

    def all
      response = site[resource].get
      decode response.body
    end
  end
end
