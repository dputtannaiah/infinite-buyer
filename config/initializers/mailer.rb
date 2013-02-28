ActionMailer::Base.default_url_options = {:host => configatron.site_address}

if ['production', 'testing'].include?(Rails.env)
  ActionMailer::Base.delivery_method = :sendmail
  ActionMailer::Base.sendmail_settings = {
      :location => '/usr/sbin/sendmail',
      :arguments => "-v"
  }
else
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.smtp_settings = {
      :address => "smtp.gmail.com",
      :port => 587,
      :domain => "localhost:3000",
      :user_name => "kbcpart1@gmail.com",
      :password => "orbital123",
      :authentication => :login,
  }
end
Mail.register_interceptor(DevelopmentMailInterceptor) if Rails.env == "development"
