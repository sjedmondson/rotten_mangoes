class Admin::UsersController < ApplicationController

  before_action do
    if current_user.id != 1
      flash[:notice] = "Thou shalt not pass!"
      redirect_to '/'
    end    
  end

  def index
    @users = User.all.page(params[:page]).per(10)
  end

end