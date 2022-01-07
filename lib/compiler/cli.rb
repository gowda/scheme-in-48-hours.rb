# frozen_string_literal: true

require 'thor'
require_relative 'parser'

module Compiler
  class CLI < Thor
    desc 'execute [--file FILENAME] [PROGRAM]', 'Run the scheme program'
    option :file
    def execute(*program)
      invoke :help if program.empty? && options[:file].nil?

      parser = Parser.new(program.join(' ')) unless program.empty?
      parser = Parser.load(options[:file]) if program.empty? && !options[:file].nil?

      parser.parse!

      puts parser.parsed.text_value
    rescue ParserError => e
      puts "Failed: #{e.message}"
    end
  end
end
