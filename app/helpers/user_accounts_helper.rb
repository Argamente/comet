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



  def set_tmp_data(key,value)
    cookies[key] = value
  end

  def get_tmp_data(key)
    cookies[key]
  end

  def del_tmp_data(key)
    cookies.delete(key)
  end



  # 检查 account_id 的合法性，如果不合法，则返回 -1
  def check_and_convert_id(param_account_id)
    id_length = param_account_id.length

    final_id = 0

    if id_length != 9
      return -1
    end

    account_id = param_account_id.to_i

    if account_id < 100000000 || account_id > 999999999
      return -1
    end

    return account_id
  end


end