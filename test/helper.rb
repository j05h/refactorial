require 'rubygems'
require 'bundler/setup'
require 'test/unit'
require 'shoulda'
require 'fakeweb'
require 'vcr'
require 'rr'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'refactorial'

class Test::Unit::TestCase
  include RR::Adapters::TestUnit
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

# override system calls
module Kernel
  def ` cmd
    cmd
  end

  def sh cmd
    cmd
  end
end

# low rent way to make sure methods are called
def assert_called instance, meth, options
  eval "def instance.#{meth}(*args); called_methods('#{meth}', args) ; end"
  yield
  assert args = instance.called_methods[meth], "Was expecting #{meth} to be called"
  assert_equal options, args, "Was expecting #{options.inspect} to match #{args}"
end

module Shoulda
  module Macros
    def should_call_runner_method command, meth, options = {:foo => :bar }
      should "call #{meth}" do
        assert_called @runner, meth, [options] do
          output = @runner.run command, options
        end
      end
    end
  end
end
