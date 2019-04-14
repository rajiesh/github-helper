require 'json'
require 'bundler/setup'
require 'pry'
require_relative 'lib/github'

task :show_tests do
  client = GitHub::Client.new(access_token: "#{ENV['ACCESS_TOKEN']}",
                              user: 'rajiesh',
                              repo: 'simple-repo')
  client.all_changes_with_label 'enhancement'
end

# Need to define the test files pattern
# Test method defenition patterns
# First filter out files which belongs to test file pattern
# In them match the lines_added to the test method pattern
# Write those that match to the HTML file with the link to the file or Commit
