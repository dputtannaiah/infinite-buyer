module ApplicationHelper
  def req
    raw %{<span style='color: red !important;'>*</span>}
  end

  def mark_required(object, attribute)
    req if object.class.validators_on(attribute).map(&:class).include? ActiveModel::Validations::PresenceValidator
  end

  def browser_title
    "Shop Online at #{configatron.site_name} | Buy Everything on Sale by Making Your Best Buyer Offer"
  end

  def meta_description
    'Buy Your Stuff at Your Price. Buyer Offers are a simple, yet Revolutionary new way to conveniently shop for and buy products at lower prices, by allowing you to Make Your Best Buyer Offer and let Sellers compete for your business.'
  end

  def meta_keywords
    'Online, Shop, Shopping Online, For Sale, Where to Buy, Buying, Coupons, Sales, Discounts, Deal, Daily Deals, Offers, Online Stores, Savings, Clothes, Clothing, Electronics, Video Games, Outlet, e-commerce'
  end

  def administration_menu
    link_to 'Administration Menu', admin_activity_url, :class => 'btn'
  end

  def display_user_type
    _display_user_type = session[:logged_in_as] == User::LoggedInAs::BUYER ? t("buyer") : (params[:controller] == 'devise/sessions' ? ('Buyer for Sellers') : (t("seller")) )
    _display_user_type ||= if user_signed_in? && current_user.logged_in_as == User::LoggedInAs::BUYER
      t("buyer")
    elsif user_signed_in? && current_user.logged_in_as == User::LoggedInAs::SELLER
      (params[:controller] == 'devise/sessions' ? ('Buyer for Sellers') : (t("seller")) )
    elsif  user_signed_in? && current_user.logged_in_as == User::LoggedInAs::BOTH
      " "
    end
  end

  def seller?
    session[:logged_in_as] == User::LoggedInAs::SELLER
  end

  def buyer?
    session[:logged_in_as] == User::LoggedInAs::BUYER
  end

  def brand
    if params[:controller].match(/super_admins/) || (devise_controller? && resource_name == :super_admin)
      link_to configatron.site_name, super_admin_root_url, :class => "brand"
    else
      link_to configatron.site_name, admin_root_url, :class => "brand"
    end
  end

  def super_admin_menu
    link_to "Super Admin Menu", super_admin_root_url, :class => 'btn'
  end

  def site_address_with_protocol
    "http://" + configatron.site_address
  end

  def handle_none(value)
    if value.present?
      block_given? ? yield : value
    else
      content_tag :span, "None given", :class => "none-given", :style=> "color:#ccc;"
    end
  end

  def get_root_url
    request.subdomain == 'blog' ? root_url(:subdomain => false) : root_url
  end

  
end

