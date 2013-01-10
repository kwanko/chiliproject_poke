# Post it plugin for Chiliproject
# Copyright (C) 2012 C2B SA
# Arnauld NYAKU

class PokeHooks < Redmine::Hook::ViewListener
  def view_layouts_base_html_head(context = {})
    css = stylesheet_link_tag 'poke', :plugin => "chiliproject_poke"
    js = javascript_include_tag 'poke', :plugin => "chiliproject_poke"

    css + js
  end
  render_on :view_issues_edit_notes_bottom, :partial => 'hooks/handle_issue_form'
end
