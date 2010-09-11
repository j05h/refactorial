require 'rubygems'
require 'test/unit'
require 'shoulda'
require 'fakeweb'
require 'vcr'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'refactorial'

class Test::Unit::TestCase
end

VCR.config do |c|
  c.cassette_library_dir = 'test/fixtures/vcr'
  c.http_stubbing_library = :fakeweb
end

def mock_http name
  VCR.use_cassette name, :record => :new_episodes do
    yield
  end
end
