class User < ApplicationRecord

  has_many :reviews

  after_destroy :user_delete_notification

  has_secure_password
  validates :email, presence: true
  validates :firstname, presence: true
  validates :lastname, presence: true

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to movies_path
    else
      render :new
    end
  end

  def full_name
    "#{firstname} #{lastname}"
  end

  protected

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation)
  end

end