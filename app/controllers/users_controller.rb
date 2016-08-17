class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id # auto log in
      redirect_to movies_path, notice: "Welcome back #{@user.firstname}!"
    else
      render :new
    end
  end

  protected

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation)
  end

  # def create
  #   user = User.find_by(email: params[:email])

  #   if user && user.authenticate(params[:password])
  #     session[:user_id] = user.id
  #     redirect_to movies_path
  #   else
  #     render :new
  #   end
  # end

end
