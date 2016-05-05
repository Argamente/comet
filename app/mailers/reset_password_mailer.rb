class ResetPasswordMailer < ApplicationMailer
  default from: "Comet <Argamente@163.com>"

  def reset_password(user_email,action_code)
    @user_email = user_email
    @action_code = action_code
    mail to:@user_email, subject:'Comet 密码修改'
  end

end
