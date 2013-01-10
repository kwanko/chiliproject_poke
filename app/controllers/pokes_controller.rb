# To change this template, choose Tools | Templates
# and open the template in the editor.

class PokesController < ApplicationController
  unloadable

  layout false

  def testpoke
    logins = params[:logins]
    @unknown_logins = logins.delete_if { |l| User.active.collect(&:login).include?(l) }
    respond_to do |format|
      format.js
    end
  end

end