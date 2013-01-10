#-- encoding: UTF-8
# Poke plugin for Chiliproject
# Copyright (C) 2012  C2B SA
# Author : Arnauld NYAKU

require 'redmine'

# require all files in lib
Dir::foreach(File.join(File.dirname(__FILE__), 'lib')) do |file|
  next unless /\.rb$/ =~ file
  require file
end

Redmine::Plugin.register :chiliproject_poke do
  name 'Chiliproject Poke'
  author 'Arnauld NYAKU'
  description 'This plugin lets you to add a poke in a note of issue'
  version '1.0.0'
  url ''
  author_url 'mailto:arnauld.nyaku@c2bsa.com'
end