class ApplicationController < ActionController::Base
  protect_from_forgery
  include ApplicationHelper

  layout :layout_by_resource

  before_filter :check_for_subdomain
  
  before_filter :set_logged_in_as_session, :user_email_and_username?, :user_seller_account?, :user_buyer_account?,
    :user_phone?, :user_category?, :except => :destroy
  
  private
  def set_logged_in_as_session
    session[:logged_in_as] ||= User::LoggedInAs::BUYER
  end

  def user_email_and_username?
    if user_signed_in? && (current_user.email.blank? || current_user.username.blank?)
      flash[:notice] = "You are signed in but your email and username are not registered. Please register here."
      redirect_to new_registration_path
    end
  end

  def user_seller_account?
    if user_signed_in? && seller? && current_user.seller_account.blank?
      flash[:notice] = "Please enter the following Seller Account information to complete your registration."
      redirect_to new_user_account_path(current_user)
    end
  end

  def user_buyer_account?
    if user_signed_in? && buyer? && current_user.buyer_account.blank?
      flash[:notice] = "Please enter the following Buyer Account information to complete your registration."
      redirect_to new_user_account_path(current_user)
    end
  end

  def user_phone?
    if user_signed_in? && seller? && current_user.seller_account && (current_user.seller_account.phone.blank? || current_user.seller_account.paypal_email.blank?)
      str = []
      str << "#{'Paypal Email ID' if current_user.seller_account.paypal_email.blank?}"
      str << "#{'and Phone Number' if current_user.seller_account.phone.blank?}"
      flash[:notice] = "Please enter the #{str.join(' ')} to compete your registration as #{t('seller')}"
      redirect_to my_account_path
    end
  end

  def user_category?
    if user_signed_in? && seller? && current_user.categories.blank?
      flash[:notice] = "As a seller Please fill the category before you proceed."
      redirect_to category_list_path
    end
  end

  protected
  
  def layout_by_resource
    if params[:controller].match(/super_admins/) || (devise_controller? && resource_name == :admin) || (devise_controller? && resource_name == :super_admin)
      "bootstrap"
    else
      "application"
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope.to_s == 'admin'
      admin_root_url
    elsif resource_or_scope.to_s == 'super_admin'
      super_admin_root_url
    else
      root_url
    end
  end

  def check_for_subdomain
    request_path = request.env['action_dispatch.request.path_parameters']
    unless(request_path[:controller] == 'blog/posts' && request_path[:action] == 'index') || (request_path[:controller] == 'blog/posts' && request_path[:action] == 'show') || (request_path[:controller] == 'blog/comments' && request_path[:action] == 'create')
      request.env['HTTP_HOST'] = request.env['HTTP_HOST'].sub('blog.','')
    end
  end
  
end
