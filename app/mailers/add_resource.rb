class AddResource < ActionMailer::Base
  default from: 'notifications@example.com'
 
  def add(user, current_user, resource)
  	@resource = resource
  	@current_user = current_user
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'New Resource Added')
  end
end
