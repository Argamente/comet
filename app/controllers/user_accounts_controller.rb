class UserAccountsController < ApplicationController

  def signup
    @userAccount = UserAccount.new
  end

  def signin
  end

  def resetpassword
    @number1 = rand(10)
    @number2 = rand(10)
    number3 = @number1 + @number2
    save_code number3
  end


  def toresetpassword
    user_email = params[:reset_password][:email]
    rec_code = params[:reset_password][:rec_code]
    flash[:email] = user_email
    flash[:rec_code] = rec_code
    flash[:number3] = get_code
    saved_rec_code = get_code
    if rec_code != saved_rec_code
      flash[:message] = "验证码错误"
      redirect_to resetpassword_url
      return
    end


    if user_email.nil? || user_email == ""
      flash[:message] = "邮箱地址错误"
      redirect_to resetpassword_url
      return
    end

    userAccount = UserAccount.find_by_email(user_email)
    if userAccount.nil?
      flash[:message] = "您的邮箱尚未注册"
      redirect_to resetpassword_url
      return
    end

    flash[:message] = "Fuck 居然找到邮箱了"

    rand_action_code = rand(999999)
    action_code = Digest::SHA1.hexdigest(rand_action_code.to_s)
    code_timestamp = Time.now.to_i.to_s
    userAccount.update(:action_code=>action_code, :code_timestamp=>code_timestamp)

    ResetPasswordMailer.reset_password(user_email,action_code).deliver_now

    redirect_to resetpassword_url

    end


    def change_password
      @user_email = params[:email]
      @action_code = params[:code]
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
    @userAccount = UserAccount.new(account_params)
    action_code = rand(999999)
    @userAccount.action_code = Digest::SHA1.hexdigest(action_code.to_s)
    @userAccount.account_state = 1
    @userAccount.code_timestamp = Time.now.to_i.to_s
    if @userAccount.save
      #AccountMailer.welcome_email(@userAccount.email).deliver_now
      SignupConfirmation.signup_confirmation(@userAccount).deliver_now
      flash[:success] = "Fuck you , Signup Successful!";
      flash[:success] = @userAccount.action_code
      sign_in @userAccount
      redirect_to root_url
    else
      flash[:success] = "Oh man, Signup faild";
      render 'signup'
    end
  end







  private
  def account_params
    params.require(:user_account).permit(:email, :password)
  end




end