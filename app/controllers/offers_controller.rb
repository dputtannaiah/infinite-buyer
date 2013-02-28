require 'general'
class OffersController < ApplicationController
  include General

  before_filter :authenticate_user!, :except => [:temp_store_offer, :splash_page]
  skip_before_filter :user_seller_account?, :user_phone?, :user_category?, :except => [:my_declined_offers,:decline]

  def index 
    @open_offers = current_user.offers.open_offers.customized_order.page(params[:page])
    @other_offers = current_user.offers.other_offers.customized_order.page(params[:page])
    @offer = current_user.offers.new
  end

  def temp_store_offer
    @open_offers = current_user.offers.open_offers.customized_order.page(params[:page])
    @other_offers = current_user.offers.other_offers.customized_order.page(params[:page])
    @offer = current_user.offers.new params[:offer]
    @offer.search_radius = 0
    @offer.zip = 12345
    if @offer.valid?
      session[:offer] = params[:offer]
      session[:referer] = splash_page_offer_path
      redirect_to splash_page_offer_path
    else
      render 'index'
    end
  end


  def splash_page
    @offer = Offer.new(session[:offer])
    session[:referer] = request.url
  end

  def create
    @offer = current_user.offers.new(session[:offer])
    @offer.search_radius = params[:search_radius]
    @offer.zip = params[:zip]
    if @offer.save
      session[:referer], session[:offer] = nil, nil
      Notifier.offer_intimation_to_admins(@offer,current_user, current_user.buyer_account).deliver if Rails.env == 'production'
      redirect_to offers_path
    else
      render 'splash_page'
    end
  end

  def extend_offer
    date = params[:date]
    @offer = current_user.offers.find(params[:offer_id])
    if @offer.update_attributes(:expire_at => Date.strptime(date, "%m/%d/%Y"))
      respond_to do |format|
        format.js 
      end
    end
  end

  def destroy
    @offer = current_user.offers.find(params[:id])
    redirect_to(@offer.cancel! ? offers_path : root_path)
  end

  def my_open_offers
    params[:sort_key] == 'price' ? (sort_order = 'ASC') : (sort_order = 'DESC')
    @open_offers = current_user.offers.open_offers.customized_order(params[:sort_key], sort_order).page(params[:page])
  end

  def my_other_offers
    params[:sort_key] == 'price' ? (sort_order = 'ASC') : (sort_order = 'DESC')
    @other_offers = current_user.offers.other_offers.customized_order(params[:sort_key], sort_order).page(params[:page])
  end

  # Decline offer
  def decline
    @offer = Offer.find(params[:id])
    DeclinedOffer.create!(:offer_id => @offer.id, :user_id => current_user.id)
    flash[:notice] = "Please check the Declined Offers tab to view the offer you just Declined."
    redirect_to declined_offers_url
  end
  
  def my_declined_offers
    @declined_offers = Offer.open_offers.declined_offers(current_user).page(params[:page])
    if params[:sort_key] == 'username'
      @declined_offers.sort! {|of1, of2| of1.user.username.downcase <=> of2.user.username.downcase if of1.user.present? && of2.user.present? }
    else
      @declined_offers = @declined_offers.customized_order(params[:sort_key])
    end
    @selected = get_selected_sort_key(params[:sort_key])
  end

end
