module Refactorial
  # Provides an interface to the gist gem
  module Gist
    attr_accessor :url
    # Creating a gist on github
    # Example
    #
    #   r = Refactorial.new
    #   r.create( :file => 'cool.rb', :ext => 'rb' )
    #   # => 'http://url.to.gist'
    #
    # Returns the url of the gist or nil if it cannot post the gist
    def create options
    end

    # The command builder will take in a set of options
    # and construct the gist command to send the gist
    # to the server
    #
    # options - The Hash options is used to build the gist command (default:{}):
    #           :private - Make the gist private
    #           :type - Set the langugage of the gist
    #           :data - the file or string of data that will be the gist
    #
    # Examples
    #
    #   command_builder :data => 'x = 1 and x += 2'
    #   # => 'gist "x = 1 and x += 2"'
    #
    #   command_builder :data => foo_bars.rb
    #   # => 'gist foo_bars.rb'
    #
    #   command_builder :data => foo_bars.rb, :private => true
    #   # => 'gist --private foo_bars.rb'
    #
    #   command_builder :data => foo_bars.rb, :type => 'rb'
    #   # => 'gist --type "rb" foo_bars.rb'
    #
    # Returns a formatted gist command
    def command_builder options
      cmd                        = 'gist'
      options[:private] and cmd += ' --private '
      options[:type]    and cmd += " --type '#{options[:type]}' "
      cmd                       += options[:data]
    end
  end
end
