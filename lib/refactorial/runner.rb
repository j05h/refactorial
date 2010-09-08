module Refactorial
  class Runner
    # Executing the runner. Possible commands are 'request' and 'setup'
    #
    # @param [ARGV] args To be parsed by OptionParser
    def initialize(args)
      options = parser args

      case options[:command]
      when 'request'
        request = Request.new
        puts request.create options[:data]
      when 'setup'
        setup = Setup.new
        setup.create_refactorial_account
      end
    end

    # Parsing the incomming args and setting the initial configuration
    #
    # @param [ARGV] args To be parsed by OptionParser
    #
    # @return [Hash] { :command => String, :data => String }
    def parser args
      Refactorial::Configure.init do |c|
        OptionParser.new do |opts|
          opts.banner = 'Usage: refactorial request ./path/to/file.rb'

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

        end.parse! args
      end

      options ={}
      options[:command] = ARGV.shift
      options[:data] = ARGV.shift
      options
    end
  end
end
