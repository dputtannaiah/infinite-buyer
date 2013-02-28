class HomeController < ApplicationController
  before_filter :clear_offer_sessions, :only => [:new_offer]
  before_filter :authenticate_user!, :only => [:reset_logged_in_as_session]

  skip_before_filter :user_buyer_account?, :user_seller_account?, :user_phone?, :user_category?

  def new_offer
    @offer = Offer.new
    redirect_to my_offers_path if user_signed_in? && seller?
  end

  def temp_store_offer
    @offer = Offer.new params[:offer]
    @offer.search_radius = 0
    @offer.zip = 12345
    if @offer.valid?
      session[:offer] = params[:offer]
      session[:referer] = splash_page_offer_path
      redirect_to splash_page_offer_path
    else
      render 'new_offer'
    end 
  end

  def clear_offer_sessions
    session[:offer], session[:referer] = nil,nil
  end

  def reset_logged_in_as_session
    session[:logged_in_as] = current_user.buyer? ? User::LoggedInAs::BUYER : User::LoggedInAs::SELLER
    redirect_to root_url
  end

  def example
    render :layout => 'facebox'
  end

  def raves
    @site_address = site_address_with_protocol
  end

  def terms_of_use_popup
    render :layout => 'facebox'
  end

  def wym_iframe
    render :layout => false
  end

  def skip
    session[:logged_in_as] = User::LoggedInAs::SELLER
    redirect_to skip_path(:affid => 141766) unless params[:affid]
  end
end
