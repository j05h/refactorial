module Refactorial
  class Request < Base
    include Refactorial::Gist

    def create data
      super data
    end

    def gist_to_js
      self.url + '.js'
    end
  end
end
