module Refactorial
  # The configuration class contains all settings delaing
  # with the refactorial gem.
  #
  # @attr_reader [Boolean] debug Turns the debugger on or off
  # @attr_reader [Boolean] verbose Turns the verbose setting on or off
  # @attr_reader [Boolean] private Marks the request as private
  # @attr_writer [String] language Sets the language of the request
  # @attr_reader [Log] log Instance of the logger
  #
  # @example
  #
  #   Refactorial::Configure.init do |c|
  #     c.debug   = true
  #     c.verbose = true
  #     c.private = false
  #     c.language    = 'rb'
  #   end
  class Configure
    include Singleton

    attr_writer :debug, :verbose, :private, :language
    attr_reader :log

    SERVER = 'http://localhost:3000'

    # Configuring the refactorial gem
    #
    # @example
    #
    #   Refactorial::Configure.init do |c|
    #     c.debug    = true
    #     c.verbose  = true
    #     c.private  = false
    #     c.language = 'rb'
    #   end
    def self.init
      yield Configure.instance
    end

    # The logger for the application. By default it will use STDOUT
    # Gets the github user.
    #
    # @return github username
    def github_user
      @user ||= `git config --get github.user`.strip
      @user ||= ENV[:GITHUB_USER].strip
    end

    #
    # @return the logger
    def logger
      if debug?
        @log ||= Logger.new STDOUT
        RestClient.log = Logger.new STDOUT
      else
        @blank ||= Logger.new nil
      end
    end

    # Is the debugger turned on?
    #
    # @return true if the debugger is on
    def debug?
      @debug
    end

    # Is the verbose setting turned on?
    #
    # @return true if the verbose setting is on
    def verbose?
      @verbose
    end

    # Is the verbose setting turned on?
    #
    # @return true if the verbose setting is on
    def private?
      @private
    end

    # Given the users input convert the language into something the system
    # can use
    def language
      case @language.to_s.downcase
      when 'rb', 'ruby'
        'rb'
      when 'js', 'javascript'
        'js'
      else
        @language
      end
    end

    # Clear out ALL configuration settings
    #
    # @return nothing
    def clear_config!
      @debug, @verbose, @private, @language = false, false, false, nil
      @log = nil
    end

    def site
      @site ||= RestClient::Resource.new SERVER
    end

  end
end
