#!/usr/bin/env ruby

require 'json'
require 'bundler/setup'
require 'pry'
require_relative 'lib/github'
require_relative 'lib/matcher'
require_relative 'lib/reporter'

client = GitHub::Client.new(access_token: ENV['access_token'],
                            user: 'rajiesh',
                            repo: 'simple-repo')
changes = client.all_changes_with_label ENV['label']
unit_test_matcher = Matcher::Test::UnitTest.new(changes)
Reporter::HTMLReport.new(unit_test_matcher.matches)




# Need to define the test files pattern
# Test method defenition patterns
# First filter out files which belongs to test file pattern
# In them match the lines_added to the test method pattern
# Write those that match to the HTML file with the link to the file or Commit
