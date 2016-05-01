class UserAccountsController < ApplicationController

  def signup
    @userAccount = UserAccount.new
  end

  def signinS
  end



  def create
    @userAccount = UserAccount.new(account_params);
    if @userAccount.save
      flash[:success] = "Fuck you , Signup Successful!";
      redirect_to signup_path
    else
      flash[:success] = "Oh man, Signup faild";
      render 'signup'
    end
  end

  def login

  end




  private
  def account_params
    params.require(:user_account).permit(:email, :password)
  end


end