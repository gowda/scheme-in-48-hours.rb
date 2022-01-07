# frozen_string_literal: true

require 'test_helper'

class PrimitivesInFileTest < Minitest::Test
  include Aruba::Api

  def setup
    setup_aruba
    append_environment_variable 'PATH', ":#{File.expand_path('../bin', __dir__)}"
  end

  def test_file_input_string
    content = '"teststring"'

    write_to_file content
    run_command_and_assert_output content
  end

  def test_integer
    content = '123'

    write_to_file content
    run_command_and_assert_output content
  end

  def test_real
    content = '123.45'

    write_to_file content
    run_command_and_assert_output content
  end

  def test_symbols
    content = '-'

    write_to_file content
    run_command_and_assert_output content
  end

  private

  def write_to_file(content)
    write_file filename, content
  end

  def run_command_and_assert_output(output)
    run_command_and_stop "cli execute --file #{aruba.config.working_directory}/#{filename}"
    assert_equal output, last_command_started.output.strip
  end

  def filename
    'code.scm'
  end
end
