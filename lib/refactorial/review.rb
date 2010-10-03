module Refactorial
  class Review < Base

    def create data, review_id, private_gist = true, ext = nil, filename = nil
      url = ::Gist.write data, private_gist, ext, filename
      post url, review_id
    end

    def post url, id
      payload = encode( { :request_id => id, :review => { :url => url } } )
      decode site[resource[:user]].post payload, :content_type => :json
    end

    def resource
      {
        :base => "reviews.json",
        :user => "#{user_base}/reviews.json"
      }
    end

    def list
      response = site[resource[:user]].get
      decode response.body
    end

    def all
      response = site[resource[:base]].get
      decode response.body
    end
  end
end
