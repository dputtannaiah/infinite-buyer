class Admins::RegistrationsController < Devise::RegistrationsController
skip_before_filter :set_logged_in_as_session, :user_email_and_username?, :user_seller_account?, :user_buyer_account?, :user_phone?, :user_category?
  protected
  
  def after_inactive_sign_up_path_for(resource)
    new_admin_session_url
  end

  def after_sign_up_path_for(resource)
    new_admin_session_url
  end

  def after_sign_in_path_for(resource_or_scope)
    current_admin_offers_url
  end

  def after_sign_out_path_for(resource_or_scope)
    admin_root_url
  end
  
end