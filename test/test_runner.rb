require 'helper'

class Refactorial::Runner
  def called_methods(method = nil, args = [])
    @called_methods ||= {}
    if(method)
      @called_methods[method] = args
    else
      @called_methods
    end
  end

  # we totally do not want our tests printing stuff to console
  def print string
    raise Exception.new("print should be called with a non nil value") unless string
    string
  end
end

class TestRunner < Test::Unit::TestCase
  def setup
    @runner = Refactorial::Runner.new []
  end

  context :parse_options do
    setup do
      @runner.parse_options "-v -p -d -t Lua".split
      @config = Refactorial::Configure.instance
    end

    should "be verbose" do
      assert @config.verbose?
    end

    should "be private" do
      assert @config.private?
    end

    should "be debuging" do
      assert @config.debug?
    end

    should "assing type to lua" do
      assert_equal "Lua", @config.type
    end
  end

  context :run do
    should "call new_request" do
      options = {:foo => :bar}
      assert_called @runner, 'new_request', [options] do
        @runner.run 'request', options
      end
    end

    should "call list_requests" do
      fail "list some requests!"
    end
  end

  context :new_request do
    should "create new requests" do
      mock_http 'new_request' do
        output = @runner.new_request({:data => "something to gistify"})
        assert_match /^Review created at .*https?:/, output
      end
    end
  end
end

