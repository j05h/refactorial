require 'helper'

class TestRequest < Test::Unit::TestCase
  def setup
    @request = Refactorial::Request.new
    stub( Refactorial::Configure.instance ).github_user.returns 'j05h'
  end

  context "resource" do
    should "create a valid users resource" do
      assert_equal "users/j05h/requests.json", @request.resource[:user]
    end

    should "create a valid resource" do
      assert_equal "requests.json", @request.resource[:base]
    end

    should "create a pop valid resource" do
      assert_equal "requests/pop.json", @request.resource[:pop]
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

    should 'pop the first request ready for review' do
      mock_http 'pop_request' do
        response = @request.pop
        assert_match /https?:\/\//, response["request"]["url"]
      end
    end
  end

  context 'get code for review' do
    setup do
      @cmd = @request.clone 'http://gist.github.com/12341231251'
    end

    should 'clone to ~/refactorial' do
      assert_match /~\/refactorial$/, @cmd
    end

    should 'clone request' do
      assert_match "git clone git@gist.github.com:12341231251.git", @cmd
    end

    should 'clone only valid http url' do
      url = 'not valid http url'
      assert_raise ArgumentError do
        @request.clone url
      end
    end

    should 'allow http url' do
      url = 'http://gist.github.com/12341231251'
      assert_nothing_raised ArgumentError do
        @request.clone url
      end
    end
  end
end

