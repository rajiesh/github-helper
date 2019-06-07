module Matcher
  class Test

    def initialize(changes)
      @all_changes = changes
    end

    def matches
      @all_changes.select do |change|
        test_change = {}
        next unless file_match?(change)
        test_change[:file_name] = change[:file_name]
        test_change[:tests_added] = method_matches(change)
        test_change[:raw_url] = change[:raw_url]
        test_change[:contents_url] = change[:contents_url]
        test_change
      end
    end

    private

    def file_match?(change)
      return false unless change[:file_name].match(Regexp.union(@file_pattern))
      true
    end

    def method_matches(change)
      change[:lines_added].select { |line| line if line.match(Regexp.union(@method_pattern)) }
    end
  end

  class UnitTest < Test

    def initialize(changes)
      super(changes)
      @file_pattern = [/.*Test.java/].freeze
      @method_pattern = [/.*Test/].freeze
    end

  end

  class IntegrationTest < Test

    def initialize(changes)
      super(changes)
      @file_pattern = [/.*IntegrationTest.java/].freeze
      @method_pattern = [/.*Test/].freeze
    end

  end
end
