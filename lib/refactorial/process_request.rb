module Refactorial
  class ProcessRequest

    def initialize(args)
      @list = args
      @list.each do |data|
        def data.to_menu_s index
          r = self["request"]
          out = "Request #" + index.to_s.green
          out += " at " + Time.parse( r["created_at"] ).strftime( "%m/%d/%Y" ).green
          out += " language " + r["language"].to_s.green
          out += " url " + r["url"].strip.green
          out.strip
        end
      end
    end

    def process
      menu

      if gets =~ /^\d*$/ and !@list[$_.to_i - 1].nil?
        puts ''
        puts "You have selected:"
        puts @list[$_.to_i - 1].to_menu_s $_.to_i
        getc "Do you want to do the review here (#{Dir.pwd.green})?(y/n)"
        gets "Where do you want to do the review? (path/to/dir)" if $_ == 'n'
        get_gist
      end
    end

    def menu
      puts "Select which request you want to review. No selection to exit."
      puts ""
      @list.each_with_index{ |r,i| puts r.to_menu_s i + 1 }
      puts "Select a request:"
    end

    def good_dir?
      cloned? || !git?
    end

    def git?
      File.exists? '.git'
    end

    def cloned?
      sh "git config --get remote.origin" == self.url
    end

    def get_gist path = './'

    end
  end
end
