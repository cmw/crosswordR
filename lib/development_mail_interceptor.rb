class DevelopmentMailInterceptor
	def self.delivering_email(message)
		message.subject = "#{message.to} #{message.subject}"
		message.to = "dylan.j.oshea@gmail.com"
	end
end