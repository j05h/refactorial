module Refactorial
  class Runner
    # Executing the runner. Possible commands are 'request' and 'setup'
    #
    # @param [ARGV] args To be parsed by OptionParser
    def initialize args
      @options = parse_options args
      @command = ARGV.shift
    end

    def print string
      puts string
    end

    def new_request options
      request = Request.new
      response = request.create options[:data]
      if url = response["request"]["url"]
        print "Review created at #{url.green}"
      else
        print "There was an error creating the gist"
      end
    end

    def list_requests options
      list = Request.new.all
      list.each_with_index do |data, index|
        request = data["request"]
        print "Request #{request["id"]} #{time_ago(request["created_at"]).to_s.green} hours ago. "+
             "language #{request["language"].green} url #{request["url"].green}"
      end
    end

    def list_reviews options
      list = Review.new.list
      list.each_with_index do |data, index|
        request = data["review"]
        print "Review ##{index} url #{request["url"].green}"
      end
    end

    def new_setup options
      setup = Setup.new
      setup.create_refactorial_account
    end

    def run command = @command, options = @options
      case command
      when 'request'
        new_request options
      when 'requests'
        list_requests options
      when 'reviews'
        list_reviews options
      when 'setup'
        new_setup options
      else
        print "#{@command} is not a recognized command"
      end
    end

    def time_ago time
      time = Time.parse(time) unless time.is_a?(Time)
      elapsed = Time.now - time
      "%5.2f" % (elapsed / 3600)
    end

    # Parsing the incomming args and setting the initial configuration
    #
    # @param [ARGV] args To be parsed by OptionParser
    #
    # @return [Hash] { :command => String, :data => String }
    def parse_options args
      Refactorial::Configure.init do |c|
        options = OptionParser.new do |opts|
          opts.banner = %Q[
#{$0}
Usage:
   refactorial setup
   refactorial request ./path/to/file
   refactorial requests
   refactorial reviews

Options: ]

          opts.on '-v', '--[no-]verbose', 'Turn on verbose' do |v|
            c.verbose = v
          end

          opts.on '-p', '--[no-]private', 'This is a private review' do |p|
            c.private = p
          end

          opts.on '-d', '--[no-]debug', 'Turn on debugging' do |d|
            c.debug = d
          end

          opts.on '-t', '--type [TYPE]', 'Set the language of the review' do |t|
            c.type = t
          end

          opts.on( "-h", "--help", "Show this message") do |opt|
            print opts
            exit
          end

          print opts if ARGV.empty?
        end.parse! args
        options
      end
    end
  end
end
