class InventoryController < ApplicationController
  skip_before_filter :user_category?, :user_buyer_account?

  before_filter :authenticate_user!

  def category_list
    @product = Category.find_by_name("Products")
    @service = Category.find_by_name("Services")
    #    @category_ids = Category.category_ids
    #    @keywords = current_user.keywords.keywords_text(@category_ids)
  end

  #Assign seller categories and keywords
  def assign_category_and_keywords
    unless params[:category_id].present?
      flash[:notice] = "Please select at least one category"
      redirect_to category_list_url
      return
    else
      status = current_user.categories.present?
      User.transaction do
        current_user.categories = Category.find(params[:category_id])
        current_user.keywords.assign_keywords(params[:category_keywords], params[:category_id], current_user)
        #@keyword = current_user.keyword
        current_user.set_logged_in_as session[:logged_in_as]
      end
      type = current_user.seller_account.get_account_type(session[:logged_in_as])
      unless status
        Notifier.user_registration(current_user, type).deliver
        Notifier.buyer_seller_intimation_to_admins(current_user, type, current_user.seller_account).deliver if Rails.env == 'production'
      end
      flash[:notice] = "Successfully Updated Categories"
    end
    redirect_to root_url
  end

end
