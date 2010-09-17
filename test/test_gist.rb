require 'test_helper'

class GistTest < Test::Unit::TestCase
  context "Refactorial can integrate with the gist gem" do
    setup do
      @gist_class = Class.new Refactorial::Base
      @gist_class.send :include, Refactorial::Gist
      @gist_instance = @gist_class.new

      # clear it out the config for every test
      @gist_instance.configuration.clear_config!
    end

    should "be have access to configuration" do
      assert_equal(Refactorial::Configure.instance, @gist_instance.configuration)
    end

    should "be able to create a gist from code snippet" do
      assert_equal("echo 'foo' | gist", @gist_instance.command_builder( 'foo' ) )
    end

    should "be able to create a gist from a file" do
      Tempfile.open( 'omg.rb' ) do |tempfile|
        assert_equal("gist #{tempfile.path}", @gist_instance.command_builder( tempfile.path))
      end
    end

    should "be able to create a PRIVATE gist from code snippet" do
      Refactorial::Configure.init do |c|
        c.private = true
      end

      assert_equal("echo 'foo' | gist --private", @gist_instance.command_builder( 'foo' ) )
    end

    should "be able to create a PRIVATE gist from a file" do
      Refactorial::Configure.init do |c|
        c.private = true
      end

      Tempfile.open( 'omg.rb' ) do |tempfile|
        assert_equal("gist --private #{tempfile.path}", @gist_instance.command_builder( tempfile.path))
      end
    end

    should "be able to create a LANGUAGE specific gist from code snippet" do
      Refactorial::Configure.init do |c|
        c.language = 'rb'
      end

      assert_equal("echo 'foo' | gist --type 'rb'", @gist_instance.command_builder( 'foo' ) )
    end

    should "be able to create a LANGUAGE specific gist from a file" do
      Refactorial::Configure.init do |c|
        c.language = 'rb'
      end

      Tempfile.open( 'omg.rb' ) do |tempfile|
        assert_equal("gist --type 'rb' #{tempfile.path}", @gist_instance.command_builder( tempfile.path))
      end
    end

    should "be able to create a PRIVATE and LANGUAGE specific gist from code snippet" do
      Refactorial::Configure.init do |c|
        c.private  = true
        c.language = 'rb'
      end

      assert_equal("echo 'foo' | gist --private --type 'rb'", @gist_instance.command_builder( 'foo' ) )
    end

    should "be able to create a PRIVATE and LANGUAGE specific gist from a file" do
      Refactorial::Configure.init do |c|
        c.private  = true
        c.language = 'rb'
      end

      Tempfile.open( 'omg.rb' ) do |tempfile|
        assert_equal("gist --private --type 'rb' #{tempfile.path}", @gist_instance.command_builder( tempfile.path))
      end
    end

  end
end
