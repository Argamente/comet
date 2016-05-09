Rails.application.routes.draw do
  root to: 'static_pages#home'

  # 页面请求
  # 注册页面
  match '/signup', to: 'user_accounts#signup', via: 'get'
  # 登录页面
  match '/signin', to: 'user_accounts#signin', via: 'get'
  # 注销页面
  match '/signout', to: 'sessions#destroy', via: 'get'
  # 密码找回页面，输入邮箱和验证码
  match '/requestresetpassword', to: 'user_accounts#requestresetpassword', via: 'get'
  # 账户激活页面
  match '/active', to:'user_accounts#active', via: 'get'
  # 修改密码页面
  match '/changepassword', to:'user_accounts#change_password', via: 'get'

  match '/pleasecheckemail', to: 'user_accounts#pleasecheckemail', via: 'get'


  match '/backtoroot', to:'static_pages#backtoroot', via:'post'


  # 向 Controller 提交数据
  match '/tosignup', to: 'user_accounts#tosignup', via: 'post'
  match '/tosignin',  to: 'sessions#tosignin', via: 'post'
  match '/torequestresetpassword', to: 'user_accounts#torequestresetpassword', via: 'post'
  match '/tochangepassword', to: 'user_accounts#tochangepassword', via:'post'
  match '/toresendemail', to: 'user_accounts#toresendemail', via: 'get'

end
