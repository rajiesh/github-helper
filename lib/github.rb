require 'octokit'

module GitHub
  class Client
    def initialize(options = {})
      raise 'Access token should be provided to use the client' unless options.keys.include? :access_token
      options.each do |key, value|
        instance_variable_set("@#{key}", value)
      end
      @client = Octokit::Client.new(access_token: @access_token)
    end

    def all_changes_with_label(label)
      changes = []
      issues = @client.issues("#{@user}/#{@repo}", labels: label, state: 'closed')
      pull_request_numbers(issues).each do |pr_number|
        files_modified_in(pr_number).each do |file_modified|
          change = {}
          next if file_modified[:patch].nil?
          change[:lines_added] = file_modified[:patch].split("\n").select { |line| line if line.start_with?('+') }
          change[:file_name] = file_modified[:filename]
          change[:raw_url] = file_modified[:raw_url]
          change[:contents_url] = file_modified[:contents_url]
          changes << change
        end
      end
      changes
    end

    private

    def pull_request_numbers(issues)
      issues.reject { |issue| issue[:pull_request].nil? }.map { |pull| pull[:number] }
    end

    def files_modified_in(pr_number)
      commit_sha = @client.pull("#{@user}/#{@repo}", pr_number)[:merge_commit_sha]
      @client.commit("#{@user}/#{@repo}", commit_sha)[:files]
    end
  end
end
