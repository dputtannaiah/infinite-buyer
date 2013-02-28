class Notifier < ActionMailer::Base
  default :from => configatron.notifier.from

  @@mailing_list = ["darshan@infinitebuyer.com", "amaresh@infinitebuyer.com", "brian@infinitebuyer.com", "as@infinitebuyer.com", "connor@infinitebuyer.com"]
  #"brian@infinitebuyer.com", "as@infinitebuyer.com", "connor@infinitebuyer.com", "darshan@infinitebuyer.com", "amaresh@infinitebuyer.com"

  def test
    mail(:to => "sukeerthiadiga@gmail.com",
      :subject => "[#{configatron.site_name}] A new user Signed Up")
  end

  def user_registration(user, type)
    @user = user
    @type = type
    mail(:to => @user.email, :subject => "#{@type =~ /buyer/i ? ("Your Infinite Buyer registration confirmation - please read carefully") : ("Your Infinite Buyer 'Seller' registration confirmation - please read carefully")}")
  end

  def offer_notice(offer, no_of_hrs)
    @offer = offer
    @no_of_hrs = no_of_hrs
    mail(:to => @offer.user.email, :subject => "Your Infinite Buyer Offer is about to expire in #{@no_of_hrs} hours")
  end

  def bid_intimation_to_buyer(bid, offer)
    @bid = bid
    @offer = offer
    mail(:to => @offer.user.email, :subject => "#{@bid.price == @offer.price ? ("Your Infinite Buyer Offer has been Accepted") :("Your Infinite Buyer Offer has been Countered") }")
  end

  def admin_notification_no_sellers(category, admin)
    @category = category
    @admin = admin
    mail(:to => @admin.email, :subject => "No Sellers Category Alert")
  end

  def seller_new_offers(offer, seller)
    @offer = offer
    @seller = seller
    mail(:to => @seller.email, :subject => "Infinite Buyer: Sellers Alert - New Buyer Offer")
  end

  def buyer_purchase_buyer(offer, bid)
    @offer = offer
    @bid = bid
    mail(:to => @offer.user.email, :subject => "Infinite Buyer - Thank You")
  end

  def buyer_purchase_seller(offer, bid)
    @offer = offer
    @bid = bid
    mail(:to => @bid.user.email, :subject => "Sellers Alert - You Made a Sale")
  end

  def offer_intimation_to_admins(offer, user, account)
    @offer = offer
    @user = user
    @account = account
    mail(:to => @@mailing_list, :subject => "Infinite Buyer - New offer is created!")
  end

  def buyer_seller_intimation_to_admins(user, type, account)
    @user = user
    @type = type
    @account = account
    mail(:to => @@mailing_list, :subject => "Infinite Buyer - #{type.capitalize} registration")
  end
  
end
