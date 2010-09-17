module Refactorial
  class Request < Base
    include Refactorial::Gist

		# Create a gist and send it to github and send the
		# resulting url to refactorial.com
		#
		# @example
		#		request = Refactorial::Request.new
		#		request.create 'foo.rb'
		#		# =>{
		#				"request":{
		#					"created_at"   : "2010-09-16T11:52:01Z",
		#					"updated_at"   : "2010-09-16T11:52:01Z",
		#					"url"          : "http://gisthub.com/433533",
		#					"language"     : "Ruby",
		#					"id"           : 15,
		#					"requester_id" : 13
		#					}
	  #				}
		#
		# @returns json results from refactorial.com
    def create data
      super data
      send_request
    end

    def send_request
        payload = ActiveSupport::JSON.encode( { :request => { :language => "Ruby", :url => self.url } } )
        configuration.site[users_resource].post payload, :content_type => :json
    end

    def users_resource
      "users/#{CGI::escape(github_user)}/#{resource}"
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
