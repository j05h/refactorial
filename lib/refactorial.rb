# All the gems
%w{rubygems gist singleton logger optparse restclient yajl cgi}.each do |gem|
  require gem
end

Dir[File.join File.dirname(__FILE__), 'refactorial', '*'].each do |file|
  require file
end
