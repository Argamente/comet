class UserAccountsController < ApplicationController

  def signup
    @userAccount = UserAccount.new(account_params);
    if @userAccount.save
      flash[:success] = "Fuck you , Signup Successful!";
      redirect_to root_url
    else
      flash[:success] = "Oh man, Signup faild";
      redirect_to root_url
    end
  end

  def signin

  end


  private
  def account_params
    params.require(:user_account).permit(:email, :password)
  end


end