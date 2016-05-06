class SessionsController < ApplicationController
  def tosignin
    userAccount = UserAccount.find_by(email: params[:user_account][:email].downcase)
    @prev_login_account = userAccount
    if userAccount
      key = Digest::SHA1.hexdigest(params[:user_account][:password])
      if key == userAccount.password
        sign_in userAccount
        flash[:success] = "Login Successful Man"
        redirect_to root_url
      else
        flash[:login_error] = "Login Faild A"
        render 'user_accounts/signin'
      end
    else
      flash[:login_error] = "Login Faild B"
      render 'user_accounts/signin'
    end
  end


  def destroy
    sign_out
    redirect_to root_path
  end

end