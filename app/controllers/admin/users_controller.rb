class Admin::UsersController < ApplicationController

  before_action :set_user, only: [:edit, :update, :destroy]

  before_action do
    if current_user.admin == false || nil
      flash[:notice] = "Thou shalt not pass!"
      redirect_to '/'
    end    
  end

  def index
    @users = User.all.page(params[:page]).per(10)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: "New user created successfully"
    else
      render :new
    end
  end 

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      redirect_to admin_users_path(@user), notice: "User updated successfully"
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    UserMailer.goodbye_email(@user).deliver
    redirect_to admin_users_path, notice: "Successfully deleted #{@user.full_name}."
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation, :admin)
  end 
    
end