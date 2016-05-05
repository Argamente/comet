module UserAccountsHelper

  def save_code(rec_code)
    cookies.permanent[:reset_password_code] = rec_code
  end

  def get_code
    rec_code = cookies[:reset_password_code]
  end

end