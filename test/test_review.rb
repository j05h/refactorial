require 'helper'

class TestReview < Test::Unit::TestCase
  def setup
    @review = Refactorial::Review.new
    stub( Refactorial::Configure.instance ).github_user.returns 'c4jun'
  end

  context "resource" do
    should "create a users valid resource" do
      assert_equal "users/c4jun/reviews.json", @review.users_resource
    end

    should "create a valid resource" do
      assert_equal "reviews.json", @review.resource
    end
  end

  context "post" do
    should "post to the server" do
      mock_http 'post_review' do
        url        = "http://gisthub.com/654321"
        request_id = 2
        response   = @review.post url, request_id
        assert_match url, response["review"]["url"]
        assert_equal  request_id, response["review"]["request_id"].to_i
      end
    end
  end

end
