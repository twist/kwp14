class AdministrationController < ApplicationController

  def index
    @users = User.all()
    @new_users = []
    @users.each do |u|
      @new_users << u if u.email =~ /@/
    end
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
