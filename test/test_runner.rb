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
    stub( Refactorial::Configure.instance ).github_user.returns 'j05h'
  end

  context :parse_options do
    setup do
      @runner.parse_options "-v -p -d -l Lua".split
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

    should "assign type to lua" do
      assert_equal "Lua", @config.language
    end
  end

  context :run do
    should_call_runner_method 'setup', 'new_setup'
    should_call_runner_method 'request', 'new_request', { :data => nil }
    should_call_runner_method 'requests', 'list_requests'
    should_call_runner_method 'reviews', 'list_reviews'
    should_call_runner_method 'pop', 'pop_request'

    should "print not a command message" do
      output = @runner.run('poop')
      assert /poop is not a recognized command/, output
    end
  end

  context :new_request do
    should "create new requests" do
      mock_http 'new_request' do
        output = @runner.new_request({:data => "something to gistify"})
        assert_match /^Review created at .*https?:/, output
      end
    end

    should "not create bad requests" do
      assert_raise(RuntimeError) do
        output = @runner.new_request({})
      end
    end
  end

  context :pop_request do
    should 'clone a request' do
      mock_http 'pop_request' do
        output = @runner.pop_request({}) 
        assert_match /^Request cloned at ~\/refactorial/, output
      end
    end
  end
end

