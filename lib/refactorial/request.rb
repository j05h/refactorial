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
      decode site[resource[:user]].post payload, :content_type => :json
    end

    # Pull the first request that does not have a review yet
    # and start working on it.  This is a quick simple way
    # to get started working on a review
    #
    # Returns json of request
    def pop
      response = site[resource[:pop]].get
      decode response.body
    end

    # Takes in a gist url and clones the project in the ~/refactorial dir
    # NOTE: we are only allowing private for now so this will only clone
    # private gist
    #
    # Returns exec system command
    def clone url
      raise ArgumentError, "Invalid url #{url}" unless /^http/ =~ url 
      git_url = url.gsub( /^http(s)?:\/\//, 'git@' ) + '.git'
      git_url = git_url.gsub( /\//, ':' )
      `git clone #{git_url} ~/refactorial`
    end

    # This is only requests that the user made, but not requests that others have made.
    def list
      response = site[resource[:user]].get
      decode response.body
    end

    def all
      response = site[resource[:base]].get
      decode response.body
    end

    # Container of all the resources for a request
    #
    # Returns hash
    def resource
      {
        :base => "requests.json",
        :pop  => "requests/pop.json",
        :user => "#{user_base}/requests.json"
      }
    end
  end
end
