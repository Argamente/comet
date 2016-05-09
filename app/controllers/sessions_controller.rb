class SessionsController < ApplicationController

  $error_login_email = "error_login_email"
  $error_login_password = "error_login_password"

  $tmp_login_email = "tmp_login_email"
  $tmp_login_password = "tmp_login_password"

  def tosignin

    flash.discard[$error_login_email]
    flash.discard[$error_login_password]

    login_email = params[:userAccount][:email]
    login_password = params[:userAccount][:password]

    set_tmp_data($tmp_login_email, login_email)
    set_tmp_data($tmp_login_password, login_password)


    if login_email.nil? || login_email == ''
      flash[$error_login_email] = "邮箱地址不能为空"
      redirect_to '/signin'
      return
    end

    if login_password.nil? || login_password == ''
      flash[$error_login_password] = "密码不能为空"
      redirect_to '/signin'
      return
    end



    userAccount = UserAccount.find_by_email(login_email.downcase)

    if userAccount
      key = Digest::SHA1.hexdigest(login_password)
      if key == userAccount.password
        sign_in userAccount
        flash[:success] = "Login Successful Man"
        del_tmp_data($tmp_login_email)
        del_tmp_data($tmp_login_password)
        redirect_to root_url
      else
        flash[$error_login_password] = "密码错误"
        redirect_to '/signin'
      end
    else
      flash[$error_login_email] = "您的邮箱尚未注册"
      redirect_to '/signin'
    end
  end


  def destroy
    sign_out
    redirect_to root_path
  end

end