class AccountMailer < ApplicationMailer
  default from: 'shaofanfan@shoushikeji.com'


 def welcome_email(receiper)
   mail( :subject => "Active Comet Account",
         :to => receiper,
         :from => "shaofanfan@shoushikeji.com",
         :date => Time.now)
end

end
