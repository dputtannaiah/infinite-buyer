class AdminController < ApplicationController
  layout "bootstrap"
  
  include ActionView::Helpers::TagHelper
  include AdminHelper

  before_filter :authenticate_admin!, :except => [:index]
  skip_before_filter :set_logged_in_as_session, :user_email_and_username?,
                     :user_seller_account?, :user_buyer_account?, :user_phone?, :user_category?

  def index
    if admin_signed_in?
      redirect_to current_admin_offers_path
    else
      redirect_to new_admin_session_path
    end
  end

  def current_admin_offers
    @admin_offers = Offer.current_admin_offers
    @product = Category.find_by_name("Products")
    @service = Category.find_by_name("Services")
    #@category = Category.first
    #@categories = ancestry_options(Category.scoped.arrange(:order => 'name')) { |i| "#{'-' * i.depth} #{(i.depth == 0 || i.depth == 1 ) ? (i.name =~ /product_home/i ?("HOME@B") : (i.name.upcase + "@B")) : (i.name)}" }
    @product = Category.find_by_name("Products")
    @service = Category.find_by_name("Services")
  end

  def history_admin_offers
    @admin_offers = Offer.current_admin_offers
    #@category = Category.first
    #@categories = ancestry_options(Category.scoped.arrange(:order => 'name')) { |i| "#{'-' * i.depth} #{(i.depth == 0 || i.depth == 1 ) ? (i.name =~ /product_home/i ?("HOME@B") : (i.name.upcase + "@B")) : (i.name)}" }
    @product = Category.find_by_name("Products")
    @service = Category.find_by_name("Services")
  end

  def seller_search
    category_ids = params[:category_ids]
    if category_ids.blank?
      flash[:notice] = "Please select at least one Category for searching"
      redirect_to :back
      return
    end
    @offer = Offer.find(params[:offer_id])
    if Category.has_unique_category_type?(category_ids)
      category = Category.find(category_ids.first)
      type = category.root.presence || category
      @offer.offer_type = type.name =~ /services/i ? Offer::Offer_type::SERVICE: Offer::Offer_type::PRODUCT
      @offer.text = params[:offer] && params[:offer][:text]
      if @offer.text.blank? || @offer.text =~ /^[\s]+$/i
        flash[:notice] = "Please enter Offer Text to continue."
        redirect_to :back
        return
      end
      @offer.save(:validate => false)

      category_query_string = Category.get_query_string(category_ids)
      keyword_query_string = params[:keyword].present? ? Category.get_keyword_query_string(category_ids, params[:keyword].strip ) : ''
      (zip, search_radius, and_or) = type.name =~ /services/i ? [(params[:zip].presence || @offer.zip), (params[:search_radius].presence || @offer.search_radius), "AND"] : [-1,-1, "OR"]
      #@seller_offers = SellerOffer.find(:all, :conditions => ["offer_id = ? ", @offer.id])
      @sellers = User.sellers(category_query_string, keyword_query_string, zip.to_i, search_radius.to_i, and_or).matching_sellers(@offer.id)
      Notifier.admin_notification_no_sellers(category, current_admin).deliver if @sellers.blank?
    else
      render 'error_message'
    end
  end

  def send_offers_to_sellers
    offer = Offer.find(params[:offer_id])
    status = false
    (params[:seller].presence || []).each do |seller_id|
      seller = User.find_by_id(seller_id)
      if offer && seller && SellerOffer.create(:user_id => seller.id, :offer_id => offer.id)
        Notifier.seller_new_offers(offer, seller).deliver
        status = true
      else
        status = false
      end
    end
    status == true ? (redirect_to history_admin_offers_path) : (render 'error_message')
  end

  def admin_category_list
    @product = Category.find_by_name("Products")
    @service = Category.find_by_name("Services")
    render :layout => 'category_list'
  end

  def category_keyword_store

  end
  
  private

  def ancestry_options(items, &block)
    return ancestry_options(items) { |i| "#{'-' * i.depth} #{i.depth == 0 ? (i.name.upcase + "@B") : i.name}" } unless block_given?

    @result = []
    items.map do |item, sub_items|
      @result << [yield(item), item.id]
      #this is a recursive call:
      @result += ancestry_options(sub_items, &block)
    end
    @result
  end

end
