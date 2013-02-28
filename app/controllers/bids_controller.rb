require 'general'

class BidsController < ApplicationController
include General

  before_filter :authenticate_user!
  skip_before_filter :user_category?, :only => [:index]
  skip_before_filter :user_buyer_account?, :except => [:index]
  skip_before_filter :user_seller_account?, :only => [:index]
  
  # To see all the bids for a particular offer. One needs to be Buyer
  def index
    @offer = current_user.offers.find(params[:offer_id])
    @bids = @offer.bids.open_bids.order_bids_by(params[:sort_key]).page(params[:page])
    @purchased_bid = @offer.bids.open_bids.purchased_bid(current_user)
  end

  def myoffers
    @my_offers = Offer.my_offers(current_user).page(params[:page])
    if params[:sort_key] == 'username'
      @my_offers.sort! {|of1, of2| of1.user.username.downcase <=> of2.user.username.downcase if of1.user.present? && of2.user.present? }
    else
      @my_offers = @my_offers.customized_order(params[:sort_key]).page(params[:page])
    end
    @selected = get_selected_sort_key(params[:sort_key])
  end

  def new # New Product Bid
    @offer = Offer.find(params[:offer_id])
    @bid = current_user.bids.new
    @product = @bid.build_product
    @bid.photos.build
  end

  def create #Create new Product bid
    date = params[:bid][:expires_at]
    @offer = Offer.find(params[:offer_id])
    @bid = current_user.bids.new(params[:bid])
    begin
      @bid.expires_at = Date.strptime(date, '%Y-%m-%d')
    rescue ArgumentError
    end
    @bid.offer = @offer
    @product = @bid.build_product(params[:product])
    @offer.price == @bid.price ? (@bid.bid_type = Bid::Bid_type::ACCEPTED) : (@bid.bid_type = Bid::Bid_type::COUNTERED)
    if @bid.save && @product.save
      Notifier.bid_intimation_to_buyer(@bid, @offer).deliver
      (offer_type, past_tensed_form) = (@bid.price != @offer.price) ? ["counter",""] : ["accept", "ed"]
      flash[:notice] = "Please check the #{offer_type.capitalize + past_tensed_form} Offers tab to view the offer you just #{offer_type.capitalize}ed."
      redirect_to (@bid.price != @offer.price) ?( counter_offers_url ) : (accepted_offers_url)
    else
      render 'new'
    end
  end

  # New Service Bid
  def new_service
    @offer = Offer.find(params[:offer_id])
    @bid = current_user.bids.new
    @service = @bid.build_service
    @bid.photos.build
  end

  #Create new Service Bid
  def create_service
    date = params[:bid][:expires_at]
    @offer = Offer.find(params[:offer_id])
    @bid = current_user.bids.new(params[:bid])
    @bid.shipping = 0.00
    begin
      @bid.expires_at = Date.strptime(date, '%Y-%m-%d')
    rescue ArgumentError
    end
    @bid.offer = @offer
    @service = @bid.build_service(params[:service])
    @offer.price == @bid.price ? (@bid.bid_type = Bid::Bid_type::ACCEPTED) : (@bid.bid_type = Bid::Bid_type::COUNTERED)
    if @bid.save && @service.save
      Notifier.bid_intimation_to_buyer(@bid, @offer).deliver
      (offer_type, past_tensed_form) = (@bid.price != @offer.price) ? ["counter",""] : ["accept", "ed"]
      flash[:notice] = "Please check the #{offer_type.capitalize + past_tensed_form} Offers tab to view the offer you just #{offer_type.capitalize}ed."
      redirect_to (@bid.price != @offer.price) ?( counter_offers_url ) : (accepted_offers_url)
    else
      render 'new_service'
    end
  end
  
  def seller_accepted_offers
    @bids = current_user.bids.accepted_offers.page(params[:page])
    if params[:sort_key] == 'username'
      @bids.sort!{ |b1, b2| b1.offer.user.username.downcase <=> b2.offer.user.username.downcase if(b1.offer.present? && b1.offer.user.present? && b2.offer.present? && b2.offer.user.present?)}
    elsif params[:sort_key] == 'text'
      @bids.sort!{ |b1, b2| b1.offer.text.downcase <=> b2.offer.text.downcase if(b1.offer.present? && b2.offer.present?)}
    else
      @bids = @bids.order_by(params[:sort_key]).page(params[:page])
    end
    @selected = get_selected_sort_key(params[:sort_key])
  end

  def seller_counter_offers
    @bids = current_user.bids.counter_offers.page(params[:page])
    if params[:sort_key] == 'username'
      @bids.sort!{ |b1, b2| b1.offer.user.username.downcase <=> b2.offer.user.username.downcase if(b1.offer.present? && b1.offer.user.present? && b2.offer.present? && b2.offer.user.present?)}
    elsif params[:sort_key] == 'text'
      @bids.sort!{ |b1, b2| b1.offer.text.downcase <=> b2.offer.text.downcase if(b1.offer.present? && b2.offer.present?)}
    else
      @bids = @bids.order_by(params[:sort_key]).page(params[:page])
    end
    @selected = get_selected_sort_key(params[:sort_key])
  end

  def product_details
    @bid = Bid.find(params[:bid_id])
    @product = @bid.product
  end

  def service_details
    @bid = Bid.find(params[:bid_id])
    @service = @bid.service
  end


end
