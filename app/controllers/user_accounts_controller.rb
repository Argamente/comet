class UserAccountsController < ApplicationController

  # 临时保存注册时提交的数据， 以下为保存到cookie 的 key
  $tmp_signup_email = 'tmp_signup_email'
  $tmp_signup_username = 'tmp_signup_username'
  $tmp_signup_password = 'tmp_signup_password'
  #$tmp_signup_province = 'tmp_signup_province'
  #$tmp_signup_city = 'tmp_signup_city'

  $error_signup_email = "error_signup_email";
  $error_signup_username = "error_signup_username";
  $error_signup_password = "error_signup_password";
  #$error_signup_location = "error_signup_location";
  $error_signup_agree = "error_signup_agree";

  $comet_already_signup_email = "comet_already_signup_email"


  # 临时保存找回密码时提交的数据，以下为保存到cookie 的 key
  $tmp_resetpassword_email = 'tmp_resetpassword_email'
  $tmp_resetpassword_code = 'tmp_resetpassword_code'
  $tmp_resetpassword_to_send_email = 'tmp_resetpassword_to_send_email'

  $need_to_send_email_value = "NeedSendEmail"

  $error_resetpassword_email = "error_resetpassword_email"
  $error_resetpassword_code = "error_resetpassword_code"




  def signup
    # 以下数据从cookie中取，作为默认数据
    @signup_email = get_signup_tmp($tmp_signup_email)
    @signup_username = get_signup_tmp($tmp_signup_username)
    @signup_password = get_signup_tmp($tmp_signup_password)

    #@signup_province = get_signup_tmp($tmp_signup_province)
    #@signup_city = get_signup_tmp($tmp_signup_city)
  end

  

  def signin
  end


  def requestresetpassword
    chars = ("A" .. "Z").to_a
    code_a = chars[rand(chars.size - 1)]
    code_b = chars[rand(chars.size - 1)]
    @final_code = code_a + ' ' + code_b
    save_code @final_code

    @resetpassword_email = get_tmp_data($tmp_resetpassword_email)
  end


  def torequestresetpassword

    flash.discard[$error_resetpassword_email]
    flash.discard[$error_resetpassword_code]

    del_tmp_data($tmp_resetpassword_email)
    del_tmp_data($tmp_resetpassword_code)

    user_email = params[:reset_password][:email]
    rec_code_a = params[:reset_password][:code_a]
    rec_code_b = params[:reset_password][:code_b]
    rec_code = rec_code_a.upcase + ' ' + rec_code_b.upcase
    saved_rec_code = get_code

    set_tmp_data($tmp_resetpassword_email, user_email)
    has_error = false


    if rec_code != saved_rec_code
      set_tmp_data($tmp_resetpassword_code, rec_code)
      flash[$error_resetpassword_code] = "验证码错误"
      has_error = true
    else
      if user_email.nil? || user_email == ""
        flash[$error_resetpassword_email] = "请输入您的邮箱"
        has_error = true
      else
        userAccount = UserAccount.find_by_email(user_email)
        if userAccount.nil?
          flash[$error_resetpassword_email] = "您的邮箱尚未注册"
          has_error = true
        end
      end
    end

    if has_error == true
      redirect_to requestresetpassword_url
      return
    end

    flash[:message] = "Fuck 居然找到邮箱了"

    rand_action_code = rand(999999)
    action_code = Digest::SHA1.hexdigest(rand_action_code.to_s)
    code_timestamp = Time.now.to_i.to_s
    userAccount.update(:action_code=>action_code, :code_timestamp=>code_timestamp)

    #ResetPasswordMailer.reset_password(user_email,action_code).deliver_now

    set_tmp_data($tmp_resetpassword_email,user_email)
    set_tmp_data($tmp_resetpassword_code, action_code)
    #del_tmp_data($tmp_resetpassword_email)
    #del_tmp_data($tmp_resetpassword_code)

    set_tmp_data($tmp_resetpassword_to_send_email,$need_to_send_email_value)
    #redirect_to resetpassword_url
    redirect_to pleasecheckemail_url

    end


    def change_password
      @user_email = params[:email]
      @action_code = params[:code]
      del_tmp_data($tmp_resetpassword_email)
      del_tmp_data($tmp_resetpassword_code)

      if @user_email.nil? || @user_email == '' || @action_code.nil? || @action_code == ''
        render_404
        return
      end

    end


    def tochangepassword

    end


  def active
    user_email = params[:email]
    action_code = params[:code]

    if user_email.nil?
      user_email = ""
    end

    if action_code.nil?
      action_code = ""
    end

    curr_timestamp = Time.now.to_i

    userAccount = UserAccount.find_by_email(user_email)

    if userAccount.nil?
      flash[:message] = "您的邮箱未注册"
      return
    end

    #检查账户的状态，是否是未激活的状态
    account_state = userAccount.account_state
    if account_state != 1
      flash[:message] = "激活连接已失效A"
      return
    end

    # 检查激活连接时间戳是否超过30天
    action_time = userAccount.code_timestamp.to_i
    time_diff = curr_timestamp - action_time
    valid_seconds = 31 * 24 * 3600

    if time_diff > valid_seconds
      flash[:message] = "激活连接已失效"
      return
    end

    #激活连接没有失效，在一个月内，激活
    if action_code == userAccount.action_code
      userAccount.update(:account_state => 0)
      flash[:message] = "激活码相同，账户激活"
    else
      flash[:message] = "激活码不相同，激活失败"
    end

  end



  #account_state: 0 正常   1: 未激活    2: 锁定

  def tosignup

    # 清除错误消息
    flash.discard[$error_signup_email]
    flash.discard[$error_signup_username]
    flash.discard[$error_signup_password]
    #flash.discard[$error_signup_location]
    flash.discard[$error_signup_agree]

    @signup_email = params[:signup][:email]
    @signup_username = params[:signup][:username]
    @signup_password = params[:signup][:password]
    #@signup_province = params[:signup][:select_province]
    #@signup_city = params[:signup][:select_city]
    @signup_agree = params[:signup][:agree]

    # 临时保存表单数据
    set_signup_tmp($tmp_signup_email, @signup_email)
    set_signup_tmp($tmp_signup_username, @signup_username)
    set_signup_tmp($tmp_signup_password, @signup_password)
    #set_signup_tmp($tmp_signup_province, @signup_province)
    #set_signup_tmp($tmp_signup_city, @signup_city)

    has_error = false

    # 检查表单错误
    if @signup_email == ''
      flash[$error_signup_email] = "邮箱不能为空"
      has_error = true
    else
      already_signup_email = get_already_signup_email($comet_already_signup_email)
      if @signup_email == already_signup_email
        flash[$error_signup_email] = "都说了你的邮箱已被注册，居然还点， Fuck"
        has_error = true
      end
    end

    if @signup_username == ''
      flash[$error_signup_username] = "用户名不能为空"
      has_error = true
    end

    if @signup_password == ''
      flash[$error_signup_password] = "密码不能为空"
      has_error = true
    end

    if @signup_agree == '0'
      flash[$error_signup_agree] = "请阅读用户协议"
      has_error = true
    end


    if has_error == true
      redirect_to '/signup'
      return
    end

    @userAccount = UserAccount.new(account_params)
    action_code = rand(999999)
    @userAccount.action_code = Digest::SHA1.hexdigest(action_code.to_s)
    @userAccount.account_state = 1
    @userAccount.code_timestamp = Time.now.to_i.to_s
    if @userAccount.save
      destroy_tmp_signup_cookie_data
      del_already_signup_email($comet_already_signup_email)
      SignupConfirmation.signup_confirmation(@userAccount).deliver_later
      flash[:success] = "Fuck you , Signup Successful!";
      flash[:success] = @userAccount.action_code
      sign_in @userAccount
      redirect_to root_url
    else
      set_already_signup_email($comet_already_signup_email, @signup_email)
      flash[$error_signup_email] = "您的邮箱已被注册"
      redirect_to '/signup'
    end
  end






  def pleasecheckemail

    flash.discard[:sendemail]
    email = get_tmp_data($tmp_resetpassword_email)
    code = get_tmp_data($tmp_resetpassword_code)

    flash[:checkemail] = email
    flash[:checkcode] = code

    if email.nil? || email == '' || code.nil? || code == ''
      flash[:fuck] = "Fuck email faild"
      render_404
      return
    end

    if get_tmp_data($tmp_resetpassword_to_send_email) == $need_to_send_email_value
      flash[:sendemail] ="to send email"
      del_tmp_data($tmp_resetpassword_to_send_email)
      ResetPasswordMailer.reset_password(email,code).deliver_later
    end
  end

  def toresendemail
    set_tmp_data($tmp_resetpassword_to_send_email,$need_to_send_email_value)
    redirect_to pleasecheckemail_url
  end


  def render_404
    render file: "#{Rails.root}/public/404.html", layout: false, status: 404
  end



  private
  def account_params
    params.require(:signup).permit(:email, :password, :username)
  end


  # 删除注册时表村的临时表单数据（在注册成功的时候就清掉）
  def destroy_tmp_signup_cookie_data
    set_signup_tmp($tmp_signup_email,'')
    set_signup_tmp($tmp_signup_username,'')
    set_signup_tmp($tmp_signup_password,'')
    #set_singup_tmp($tmp_signup_province,'')
    #set_signup_tmp($tmp_signup_city,'')
  end


end