module SessionsHelper

	def logged_in?
		!current_user.nil?
	end

	def admin?
		current_user[:admin]
	end

end
