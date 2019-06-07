require 'markaby'

module Reporter
  class HTMLReport
    def initialize
      @reportfile = File.open('changes.html', 'w')
      @mab = Markaby::Builder.new
    end

    def generate_report(changes_to_report, label, user, repo)
      @mab.html do
        head { title "Report for #{user}/#{repo} : Tests add/modified for label #{label}" }
        div do
          h1 "Report for #{user}/#{repo} : Tests add/modified for label #{label}"
          table do
            tr do
              th 'File Name'
              th 'Changes'
              th 'raw URL'
            end
            changes_to_report.each do |change|
              tr do
                td change[:file_name].split("/").last
                td do
                  change[:lines_added].join("<br/>")
                end
                td do
                  a href: change[:raw_url].to_s do
                    "ViewFile"
                  end
                end
              end
            end
          end
        end
      end
      @reportfile.puts @mab.to_s
    end
  end
end
