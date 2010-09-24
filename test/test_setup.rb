require 'helper'

class TestSetup < Test::Unit::TestCase

  def setup
    @setup = Refactorial::Setup.new
  end

  context :github do
    should 'have a user configured' do
      assert_equal 'git config --get github.user', @setup.github_user
    end

    should 'have a token' do
      assert_equal 'git config --get github.token', @setup.github_token
    end

    should 'have account' do
      assert @setup.github_account?
    end
  end

  context 'without an account' do

    should 'have NOT account' do
      mock_http 'get_no_user' do
        stub( Refactorial::Configure.instance ).github_user.returns 'n00b'
        assert_equal false, @setup.refactorial_account?
      end
    end

  end

  context 'with account new_guy' do

    setup do
      stub( Refactorial::Configure.instance ).github_user.returns 'new_guy'
    end

    should 'be able to create an account' do
      mock_http 'new_user' do
        assert @setup.create_account
      end
    end

    should 'be able to get an account' do
      mock_http 'existing_account' do
        response = @setup.get_account
        user = response['user']
        assert_match 'new_guy', user['github_account']
        assert_match '1585ca00-a92e-012d-87c3-001f5beb96d0', user['access_token']
      end
    end

  end

end
