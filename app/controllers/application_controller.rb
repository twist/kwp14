#encoding: utf-8
require 'pp'
class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :filter_list, :sort_list

  private
  def filter_list
    @tags = Tag.all()
    @filters = []
    @tags.each do |t|
      @filters.push t.title
    end
    return @filters
  end

  def sort_list
    return ["Bewertung", "Nummer", "Neueste Kommentare"]
  end
    
      
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end
      
  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end

  def require_user
    unless current_user
      flash[:notice] = "Bitte melden Sie sich an um diese Funktionalität zu nutzen"
      redirect_to :back 
      return false

    end

  end
end
