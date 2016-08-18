class UserMailer < ApplicationMailer

  default from: 'notifications@rottenmangoes.com'

  def goodbye_email(user)
    @user = user
    mail(to: @user.email, subject: 'User Deleted')
  end 

end
