require 'json'
require 'bundler/setup'
require 'pry'
require_relative 'lib/github'
require_relative 'lib/matcher'

task :show_tests do
  client = GitHub::Client.new(access_token: 'ef4e2db323edecdf6f754f870b8078cf84477fe3',
                              user: 'rajiesh',
                              repo: 'simple-repo')
  changes = client.all_changes_with_label 'enhancement'
  unit_test_matcher = Matcher::Test.UnitTest.new
  html_report = Reporter.HTMLReport.new
  changes.each  do |change|
    html_report.unit_tests_report(change) if unit_test_matcher.match?(change)
  end
  binding.pry
end

# Need to define the test files pattern
# Test method defenition patterns
# First filter out files which belongs to test file pattern
# In them match the lines_added to the test method pattern
# Write those that match to the HTML file with the link to the file or Commit
