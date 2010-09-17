require 'test_helper'

class ConfigureTest < Test::Unit::TestCase

  context "Refactorial can be configured" do
    setup do
      @instance = Refactorial::Configure.instance
      @instance.clear_config!
    end

    should "be able to configure a debug mode" do
      assert @instance.respond_to? :debug=
    end

    should "be able to query debug mode" do
      assert @instance.respond_to? :debug?
    end

    should "be able to configure a verbose mode" do
      assert @instance.respond_to? :verbose=
    end

    should "be able to query verbose mode" do
      assert @instance.respond_to? :verbose?
    end

    should "be able to configure a private gist" do
      assert @instance.respond_to? :private=
    end

    should "be able to query private mode" do
      assert @instance.respond_to? :private?
    end

    should "be able to configure a language for a gist" do
      assert @instance.respond_to? :language=
    end

    should "expose the configure instance in the init block" do
      Refactorial::Configure.init do |c|
        assert_equal( @instance, c )
      end
    end

    should "be able get the git hub user" do
      assert_equal( 'git config --get github.user', @instance.github_user )
    end

  end
end
