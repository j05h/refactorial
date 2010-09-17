require 'helper'

class TestRequest < Test::Unit::TestCase
  def setup
    @request = Refactorial::Request.new
    stub( Refactorial::Configure.instance ).github_user.returns  'j05h'
  end

  context "resource" do
    should "create a valid resource" do
      assert_equal "users/j05h/requests.json", @request.users_resource
    end
  end

  context "post" do
    should "post to the server" do
      mock_http 'post_request' do
        url = "http://gisthub.com/123456"
        lang = "Lua"
        response = @request.post url, lang
        assert_match url, response["request"]["url"]
        assert_match lang, response["request"]["language"]
      end
    end
  end

  context "create data" do
    should "create a new gist" do
      mock_http 'create_gist' do
        response = @request.create "puts 'hello world'"
        assert_match "//gist.github.com/70ad7416bdea79654996", response["request"]["url"]
      end
    end
  end

  context "list data" do
    should "list current user requests" do
      mock_http 'list_requests' do
        response = @request.all
        assert_equal 20, response.size
        response.each do |request|
          assert_match /https?:\/\//, request["request"]["url"]
        end
      end
    end

    should "list all current requests" do
      mock_http 'all_requests' do
        response = @request.list
        assert_equal 5, response.size
        response.each do |request|
          assert_match /https?:\/\//, request["request"]["url"]
        end
      end
    end
  end
end

