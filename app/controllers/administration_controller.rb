class AdministrationController < ApplicationController

  def index
    @users = User.all()


  end

end
