module Matcher
  module Test
    class UnitTest

      METHOD_PATTERN = [/.*Test/].freeze
      FILE_PATTERN = [/.*Test.java/].freeze

      attr_accessor :all_changes

      def initialize(changes)
        @all_changes = changes
      end

      def matches
        @all_changes.select do |change|
          unit_test_change = {}
          next unless file_match?(change)
          unit_test_change[:file_name] = change[:file_name]
          unit_test_change[:tests_added] = method_matches(change)
          unit_test_change[:raw_url] = change[:raw_url]
          unit_test_change[:contents_url] = change[:contents_url]
          return unit_test_change
        end
      end

      def file_match?(change)
        return false unless change[:file_name].match(Regexp.union(FILE_PATTERN))
        true
      end

      def method_matches(change)
        change[:lines_added].select { |line| line if line.match(Regexp.union(METHOD_PATTERN)) }
      end
    end

    class IntegrationTest
    end
  end
end
