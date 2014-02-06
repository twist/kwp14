class AdministrationController < ApplicationController
  before_filter :require_user
  before_filter :require_admin

  def index
    @users = User.all()
    @new_users = []
    @users.each do |u|
      @new_users << u if u.email =~ /@/
    end
    @topics = Topic.all()
    @topics.sort! {|a,b| a.votecount <=> b.votecount}

  end


  def encrypt

    @users = User.all()
    @new_users = []
    @users.each do |u|
      if u.email =~ /@/
        u.encrypt_email_and_save
      end
    end

    redirect_to topics_path




  end

end
