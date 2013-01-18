class UserMailer < ActionMailer::Base
	full_sender = "Crossword Caf\u00e9 <info@crossword-cafe.com>"

	# Default values for sending email
	default from: full_sender

	def welcome_email(user)
	    @user = user
	    full_name = @user.first_name + ' ' + @user.last_name
	    email_with_name = "#{full_name} <#{@user.email}>"
	    @url  = "http://www.crossword-cafe.com"
	    mail(:to => email_with_name,
	    	 :subject => "Welcome to Crossword Caf\u00e9")
	end

end
