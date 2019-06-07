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
unit_test_matcher = Matcher::UnitTest.new(changes)
Reporter::HTMLReport.new().generate_report(unit_test_matcher.matches, ENV['label'], 'rajiesh', 'simple-repo')
