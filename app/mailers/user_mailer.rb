class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.reset_password_email.subject
  #
  def reset_password_email(user)
    @user = User.find(user.id)
    @url = edit_password_reset_url(@user.reset_password_token)
    # subject：メールの件名、to: メールを送る相手
    # mail(to: user.email,
    #      subject: 'パスワードリセット')
    mail(to: user.email,
        subject: t("defaults.password_reset"))
  end
end
