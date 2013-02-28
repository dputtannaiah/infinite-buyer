class UsersController < InheritedResources::Base
  before_filter :authenticate_user!, :except => [:buyer, :seller]
  skip_before_filter :user_phone?, :user_category?, :user_seller_account?, :user_buyer_account?, :only => [:buyer, :seller]

  actions :update, :edit

  def update
    super do |format|
      format.html { redirect_to root_path }
    end
  end

  def buyer
    session[:logged_in_as] = User::LoggedInAs::BUYER
    #logged in as seller and user clicks on buyer
    if user_signed_in? && current_user.logged_in_as == User::LoggedInAs::SELLER && current_user.seller_account.present?
      current_user.set_logged_in_as session[:logged_in_as]
    end
    redirect_to user_signed_in? ? offers_path : new_user_session_path
  end

  def seller
    session[:logged_in_as] = User::LoggedInAs::SELLER
    redirect_to user_signed_in? ? my_offers_path : new_user_session_path
  end

end