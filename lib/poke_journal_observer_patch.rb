# Poke plugin for Chiliproject
# Copyright (C) 2012 C2B SA
# Arnauld NYAKU

module PokeJournalObserverPatch
  def self.included(base)
    base.send(:include, InstanceMethodsPatch)
    base.class_eval do
      unloadable
      alias_method_chain :after_create, :poke
    end
  end
end

module InstanceMethodsPatch
  def after_create_with_poke(journal)
    after_create_without_poke(journal)
    PokeMailer.deliver_issue_edit_poke(journal) if journal.type == "IssueJournal" && !journal.initial? && journal_notes_content_poke?(journal)
  end

  private
    def journal_notes_content_poke?(journal)
      content_poke = false
      journal.notes.each_line do |line|
         content_poke = true if line.strip.first != ">" && line =~ /poke @\w+[\.]{1}\w+/
         break if content_poke
      end
      content_poke
    end
end

JournalObserver.send(:include, PokeJournalObserverPatch)


