class Signup < ActionMailer::Base
  default from: 'notifications@example.com'
 
  def welcome_email(user)
  	@email = "jaybrar79@gmail.com"
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @email, subject: 'New Group Registered')
  end
end
