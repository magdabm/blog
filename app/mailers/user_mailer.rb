class UserMailer < ApplicationMailer

  default from: 'form@example.com'

  def liked_article(user)
    @user = user
    mail(to: @user.email, subject: 'Liked article')
  end

end
