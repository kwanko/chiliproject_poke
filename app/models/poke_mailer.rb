
class PokeMailer < Mailer
  def issue_edit_poke(journal)
    issue = journal.journaled.reload
    redmine_headers 'Project' => issue.project.identifier,
                    'Issue-Id' => issue.id,
                    'Issue-Author' => issue.author.login,
                    'Type' => "Issue"
    redmine_headers 'Issue-Assignee' => issue.assigned_to.login if issue.assigned_to
    
    references issue

    recipients journal_notes_pokers(journal)

    s =  "[#{l(:text_expected_action)}] "
    s << "[#{issue.project.name} - #{issue.tracker.name} ##{issue.id}] "
    s << "(#{issue.status.name}) " if journal.details['status_id']
    s << issue.subject

    subject s
    body :issue => issue,
         :journal => journal,
         :issue_url => url_for(:controller => 'issues', :action => 'show', :id => issue)

    render_multipart('issue_edit_poke', body)
  end

  private
    def journal_notes_pokers(journal)
      pokers = []
      journal.notes.each_line do |line|
        pokers << line.strip.scan(/poke @(\w+[\.]{1}\w+)/).collect {|login| User.find_by_login(login).mail } if line.strip.first != ">"
      end
      pokers.flatten.uniq
    end
end
