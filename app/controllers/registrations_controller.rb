class RegistrationsController < Devise::RegistrationsController
  skip_before_filter :user_email_and_username?, :user_seller_account?, :user_buyer_account?, :user_category?, :user_phone?,
    :only => [:new_registration, :create_registration]

  before_filter :authenticate_user, :only => [:new_registration, :create_registration]
  before_filter :verify_presence_of_email_and_username, :only => [:new_registration, :create_registration]

  def create
    build_resource
    if resource.save
      resource.set_logged_in_as session[:logged_in_as]
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_in(resource_name, resource)
        respond_with resource, :location => after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

  def new_registration
    @user = current_user
  end

  def create_registration
    @user = current_user
    Devise.reconfirmable = false
    if @user.update_attributes(params[:user])
      flash[:notice] = "Thanks for registering as #{display_user_type}. Please enter your account information to complete the registeration"
      redirect_to new_user_account_path(@user)
    else
      render 'new_registration'
    end
  end

  private

  def authenticate_user
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end

  protected
  def after_sign_in_path_for(resource_or_scope)
    session[:referer] || root_url
  end

  def after_sign_out_path_for(resource_or_scope)
    root_url
  end

  def after_inactive_sign_up_path_for(resource)
    flash[:notice] = "Thanks for registering as #{display_user_type}. Please enter your account information to complete the registeration"
    new_user_account_path(resource)
  end

  def after_sign_up_path_for(resource)
    flash[:notice] = "Thanks for registering as #{display_user_type}. Please enter your account information to complete the registeration"
    new_user_account_path(resource)
  end

  def verify_presence_of_email_and_username
    @user = current_user
    if @user.username_email_present?
      flash[:notice] = "Your email is already registered. Please go to my account to edit your profile."
      redirect_to root_path
    end
  end
end