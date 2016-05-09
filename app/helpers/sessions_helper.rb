module SessionsHelper
  def sign_in(userAccount)
    remember_token = UserAccount.account_new_remember_token
    cookies.permanent[:remember_token] = remember_token
    userAccount.update_attribute(:remember_token,UserAccount.encrypt(remember_token))
    self.current_account = userAccount
  end


  def current_account=(userAccount)
    @current_account = userAccount
  end

  def signed_in?
    !current_account.nil?
  end

  def current_account?(userAccount)
    userAccount == current_account
  end

  def current_account
    remember_token = UserAccount.encrypt(cookies[:remember_token])
    @current_account ||= UserAccount.find_by(remember_token: remember_token)
  end


  def signed_in_account
    unless signed_in?
      store_location
      redirect_to signin_url, notice:"Please sign in"
    end
  end


  def sign_out
    self.current_account = nil
    cookies.delete(:remember_token)
  end



  def redirect_back_or
    redirect_to(session[:return_to])
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.fullpath
  end


end