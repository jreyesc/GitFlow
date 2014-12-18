class UserNotifier < ActionMailer::Base
  default :from => 'athenainformative@gmail.com'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_list_to_shop(user, items)
  	@email = user
  	@recommendation_items = items
    mail( :to => "#{user}", :subject => 'Athena shopping list' )
  end
end

