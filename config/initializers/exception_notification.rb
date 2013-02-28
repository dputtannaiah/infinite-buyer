unless Rails.env == "development"
  InfiniteBuyer::Application.config.middleware.use ExceptionNotifier,
                                                   :email_prefix => "[InfiniteBuyer#ERROR] #{Rails.env}",
                                                   :sender_address => 'dputtannaiah@firminteractive.com',
                                                   :exception_recipients => configatron.developers.email_address
end