# frozen_string_literal: true

require 'test_helper'

class PrimitivesTest < Minitest::Test
  include Aruba::Api

  def setup
    setup_aruba
    prepend_environment_variable 'PATH', "#{File.expand_path('../bin', __dir__)}:"
  end

  def test_string
    run_command_and_stop 'cli execute \"teststring\"'
    assert_equal '"teststring"', last_command_started.output.strip
  end

  def test_integer
    run_command_and_stop 'cli execute 123'
    assert_equal '123', last_command_started.output.strip
  end

  def test_real
    run_command_and_stop 'cli execute 123.45'
    assert_equal '123.45', last_command_started.output.strip
  end

  def test_symbols
    '-+!$#'.chars.each do |sym|
      run_command_and_stop "cli execute '#{sym}'"
      assert_equal sym, last_command_started.output.strip
    end
  end
end
