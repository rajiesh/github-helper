module Matcher
  class Test
    attr_accessor :test_change

    def match?(change)
      @test_change = change
      return 'New tests added' if file_match? && method_match?
      return 'Tests modified' if file_match? && !method_match?
      'No unit test change'
    end
  end

  class UnitTest < Test
    METHOD_PATTERN = ['*Test', '*'].freeze
    FILE_PATTERN = ['*Test.java'].freeze

    def file_match?
      return false unless @test_change[:file_name].match(Regexp.union(FILE_PATTERN))
      true
    end

    def method_match?
      @test_change[:lines_added].each { |line| line if line.match(Regexp.union(METHOD_PATTERN)) }
    end
  end

  class IntegrationTest < Test
  end
end
