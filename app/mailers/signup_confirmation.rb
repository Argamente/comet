class SignupConfirmation < ApplicationMailer
  default from: "Comet <Argamente@163.com>"

  def signup_confirmation(userAccount)
    @user_email = userAccount.email
    @user_sec_password = userAccount.password
    @user_account_action_code = userAccount.action_code
    mail to: @user_email , subject: "请激活您的账号，完成注册"
  end
end
