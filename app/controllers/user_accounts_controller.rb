class UserAccountsController < ApplicationController

  def signup
    @userAccount = UserAccount.new
  end

  def signin
  end

  def resetpassword

  end



  def tosignup
    @userAccount = UserAccount.new(account_params);
    if @userAccount.save
      #AccountMailer.welcome_email(@userAccount.email).deliver_now
      SignupConfirmation.signup_confirmation(@userAccount).deliver_now
      flash[:success] = "Fuck you , Signup Successful!";
      sign_in @userAccount
      redirect_to root_url
    else
      flash[:success] = "Oh man, Signup faild";
      render 'signup'
    end
  end


  def toresetpassword

  end




  private
  def account_params
    params.require(:user_account).permit(:email, :password)
  end


end