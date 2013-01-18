require 'development_mail_interceptor'

ActionMailer::Base.smtp_settings ={
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => 'crossword-cafe.com',
  :user_name            => 'info@crossword-cafe.com',
  :password             => 'cafepassword',
  :authentication       => 'plain',
  :enable_starttls_auto => true
}

ActionMailer::Base.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?
