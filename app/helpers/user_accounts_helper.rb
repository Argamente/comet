module UserAccountsHelper

  def save_code(rec_code)
    cookies.permanent[:reset_password_code] = rec_code
  end

  def get_code
    rec_code = cookies[:reset_password_code]
  end


  # 注册的时候临时保存一下上次提交的表单
  def set_signup_tmp(key,value)
    cookies[key] = value
  end

  # 获取注册时上次临时保存的表单
  def get_signup_tmp(key)
    cookies[key]
  end


  # 注册时如果邮箱已经被注册了，则临时保存一下，防止狂点注册按钮
  def set_already_signup_email(key,email)
    cookies[key] = email
  end

  # 尝试获取一下是否有保存的已经注册的邮箱
  def get_already_signup_email(key)
    cookies[key]
  end

  # 注册成功后，就清一下保存的已经注册的邮箱
  def del_already_signup_email(key)
    cookies.delete(key)
  end


end