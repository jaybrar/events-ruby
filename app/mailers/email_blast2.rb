class EmailBlast2 < ActionMailer::Base
  default from: "from@example.com"

  def email_all(user, current_user, message)
  	@message = message
  	@current_user = current_user
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'New Message')
  end
  
end
