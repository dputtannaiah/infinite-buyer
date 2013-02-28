class SessionsController < Devise::SessionsController

  skip_before_filter :user_email_and_username?, :user_seller_account?, :user_buyer_account?, :user_category?, :user_phone?,
                     :only => [:destroy]

  after_filter :clear_referer_session, :only => [:destroy]

  private 
  
  def clear_referer_session
    session[:referer], session[:offer], session[:logged_in_as] = nil
  end

end
