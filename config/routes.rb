Rails.application.routes.draw do
  root to: 'static_pages#home'

  #------------------帐号相关-----------------#
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
  match '/resetpassword', to:'user_accounts#resetpassword', via: 'get'
  # 找回密码邮件已发送
  match '/pleasecheckemail', to: 'user_accounts#pleasecheckemail', via: 'get'
  # 返回首页
  match '/backtoroot', to:'static_pages#backtoroot', via:'post'
  #密码找回已重设成功
  match '/resetpasswordsuccessful', to:'user_accounts#resetpasswordsuccessful', via:'get'


  # 提交注册数据
  match '/tosignup', to: 'user_accounts#tosignup', via: 'post'
  # 提交登录数据
  match '/tosignin',  to: 'sessions#tosignin', via: 'post'
  # 提交请求找回密码数据，验证码，邮箱，然后会发送邮件
  match '/torequestresetpassword', to: 'user_accounts#torequestresetpassword', via: 'post'
  # 通过找回密码连接，打开密码重设页面，提交的数据
  match '/toresetpassword', to: 'user_accounts#toresetpassword', via:'post'
  # 找回密码中邮件已发送，点了 重新发送 按钮，重新发送邮件
  match '/toresendemail', to: 'user_accounts#toresendemail', via: 'get'
  #-----------------------------------------------#


  #----------------- 个人资料相关 ----------------#
  # 访问个人资料页
  match '/people/:id', to: 'peoples#show', via: 'get'
  # 更新头像信息
  match '/people/update/head_icon', to: 'peoples#update_head_icon', via:'post'
  # 更新基础资料
  match '/people/update/basic_info', to: 'peoples#update_basic_info', via:'post'
  # 更新近况
  match '/people/update/life_memory', to: 'peoples#update_life_memory', via:'post'
  # 更新参与过的项目
  match '/people/update/person_joined_project', to: 'peoples#update_person_joined_project', via:'post'
  # 更新最近发表过的项目评论
  match '/people/update/project_comment', to: 'peoples#update_project_comment', via:'post'
  # 更新教育信息
  match '/people/update/education', to: 'peoples#update_education', via:'post'
  # 更新工作经历
  match '/people/update/work_experience', to: 'peoples#update_work_experience', via:'post'
  #-----------------------------------------------#



  match '/people/update/ajaxtest', to: 'peoples#ajaxtest', via:'get'



end
