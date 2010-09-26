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

  context "create data" do
    should "create a new gist" do
      mock_http 'create_gist' do
        response = @review.create "puts 'hello world'", 2
        assert_match "//gist.github.com/70ad7416bdea79654996", response["review"]["url"]
        assert_equal  2, response["review"]["request_id"].to_i
      end
    end
  end

  context "list data" do
    should "list current user reviews" do
      mock_http 'list_reviews' do
        response = @review.all
        assert_equal 7, response.size
        response.each do |review|
          assert_match /https?:\/\//, review["review"]["url"]
        end
      end
    end

    should "list all current reviews" do
      mock_http 'all_reviews' do
        response = @review.list
        assert_equal 3, response.size
        response.each do |review|
          assert_match /https?:\/\//, review["review"]["url"]
        end
      end
    end
  end
end
