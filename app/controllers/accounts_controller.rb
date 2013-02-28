class AccountsController < InheritedResources::Base
  #actions :new
  skip_before_filter :user_buyer_account?, :user_seller_account?, :user_phone?, :user_category?

  before_filter :authenticate_user!
  before_filter :set_account, :only => [:new, :create]

  def new
    @account
  end
  
  def create
    if @account.save
      type = @account.get_account_type(session[:logged_in_as])
      Notifier.user_registration(current_user, type).deliver if type =~ /buyer/i
      Notifier.buyer_seller_intimation_to_admins(current_user, type, @account).deliver if (type =~ /buyer/i && Rails.env == 'production')
      redirect_to customized_url(session[:referer])
    else
      render 'new'
    end
  end

  def my_account
    @account = current_user.buyer_account.presence || current_user.build_buyer_account
  end

  def edit_buyer
    @account = current_user.buyer_account.presence || current_user.build_buyer_account
  end

  def update_buyer
    @user = current_user
    @account = @user.buyer_account.presence || @user.build_buyer_account(params[:buyer_account])
    if @account.new_record? && @account.save && @user.update_attributes(params[:user])
      flash[:notice] = "Buyer Account created successfully"
      Notifier.buyer_seller_intimation_to_admins(@user, "buyer", @account).deliver if Rails.env == 'production'
    elsif @account.update_attributes(params[:buyer_account]) && @user.update_attributes(params[:user])
      flash[:notice] = "Buyer Account updated successfully"
    end
  end

  def edit_seller
    @account = current_user.seller_account.presence || current_user.build_seller_account(params[:seller_account])
  end

  def update_seller
    @user = current_user
    @account = @user.seller_account.presence || @user.build_seller_account(params[:seller_account])
    if @account.new_record? && @account.save && @user.update_attributes(params[:user])
      Notifier.buyer_seller_intimation_to_admins(@user, "seller", @account).deliver if Rails.env == 'production'
      flash[:notice] = "Seller Account created successfully"
    elsif @account.update_attributes(params[:seller_account]) && @user.update_attributes(params[:user])
      flash[:notice] = "Seller Account updated successfully"
    end
  end

  private

  def set_account
    if buyer? && current_user.buyer_account.blank?
      @account = current_user.build_buyer_account(params[:buyer_account])
    elsif seller? && current_user.seller_account.blank?
      @account = current_user.build_seller_account(params[:seller_account])
    else
      account = buyer? ? "Buyer" : "Seller"
      flash[:notice]= "Your #{account} Account is aleady registered!"
      redirect_to root_url
    end
  end

  def customized_url(session)
    if session.present?
      if session == new_user_registration_url || session == new_user_session_url || session == user_confirmation_url || new_user_confirmation_url
        root_url
      else
        session
      end
    else
      root_url
    end
  end

  
end
