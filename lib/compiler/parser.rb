# frozen_string_literal: true

require 'treetop'

module Compiler
  class ParserError < StandardError
    def initialize(msg = nil)
      super
    end
  end

  class Parser
    Treetop.load File.expand_path('../grammars/scheme', __dir__)

    attr_reader :source

    def self.load(file)
      new(File.readlines(File.expand_path("../../#{file}", __dir__), chomp: true).join(' '))
    end

    def initialize(source)
      @source = source
    end

    def parse!
      raise ParserError, failure_reason if failed?

      parsed
    end

    def parsed?
      !failed?
    end

    def failed?
      parsed.nil?
    end

    def failure_reason
      instance.failure_reason
    end

    def parsed
      @parsed ||= instance.parse(source)
    end

    def instance
      @instance ||= SchemeParser.new
    end
  end
end
