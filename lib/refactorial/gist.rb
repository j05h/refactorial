module Refactorial
  # Provides an interface to the gist gem
  # @attr [String] url Url of the gist
  module Gist
    attr_accessor :url
    # Creating a gist on github
    #
    # @param [String] data tThe file name or a string of the code to be reviewed
    #
    # @example
    #
    #   r = Refactorial::Request.new
    #   r.create 'cool.rb'
    #   # => 'http://url.to.gist'
    #
    # @return url of the gist or nil if it cannot create the gistd
    def create data
      command = command_builder data
      self.url = `#{command}`
      self.url
    end

    # The command builder will take in a set of options
    # and construct the gist command to send the gist
    # to the server
    #
    # @param [String] :data The file name or a string of the code to be reviewed
    #
    # @example
    #
    #   command_builder 'x = 1 and x += 2'
    #   # => 'echo "x = 1 and x += 2" | gist'
    #
    #   command_builder 'foo_bars.rb'
    #   # => 'gist foo_bars.rb'
    #
    # @return a formatted gist command
    def command_builder data
      cmd                            = 'gist'
      configuration.private? and cmd += ' --private '
      configuration.language and cmd += " --type '#{configuration.language}' "

      if File.exists? data
        cmd += " #{data} "
      else
        cmd  = "echo '#{data}' | " + cmd
      end

      cmd
    end

    # Public git clone of the code snippet
    def public_clone
      self.url =~ /(\d+)/
      "git://gist.github.com/#{$1}.git"
    end

    # Private git clone if the code snippet
    def private_clone
      self.url =~ /(\d+)/
      "git@gist.github.com/#{$1}.git"
    end

  end
end


