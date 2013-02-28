class Bid < ActiveRecord::Base
  paginates_per 5

  PERCENT_TO_MERCHANT = Float(6)/100

  module Bid_type
    ACCEPTED = 0
    COUNTERED = 1
  end

#  monetize :price
#  monetize :shipping, :as => :shipping_price

  validates :price, :presence => true, :numericality => {:greater_than => 0}
  validates :offer_id, :user_id, :shipping, :presence => true, :numericality => true
  validates :offer_id, :uniqueness => {:scope => [:user_id], :message => 'You cannot accept/counter more than once for an Offer'}
  validates :expires_at, :expires_at => true
  validates_datetime :expires_at

  belongs_to :user
  belongs_to :offer

  has_many :purchases
  has_many :photos

  has_one :product, :dependent => :destroy
  has_one :service, :dependent => :destroy

  accepts_nested_attributes_for :photos, :allow_destroy => true

  scope :accepted_offers, joins(:offer).where("ROUND(bids.price) = ROUND(offers.price)")
  scope :counter_offers, joins(:offer).where("ROUND(bids.price) <> ROUND(offers.price)")
  scope :open_bids, joins(:offer, :user).where("bids.expires_at <= offers.expire_at")
  scope :order_by, proc { |sort_key, sort_order| order(" #{sort_key.presence || 'created_at'} #{sort_order.presence || 'DESC'}") }
  #  scope :purchased_bid, proc { |current_user|
  #    first(:joins =>[:purchases], :conditions => ["purchases.user_id = ? AND purchases.purchased_at IS NOT NULL", current_user.id])
  #  }

  class << self
    def purchased_bid(current_user)
      first(:joins => [:purchases], :conditions => ["purchases.user_id = ? AND purchases.purchased_at IS NOT NULL", current_user.id])
    end

    def order_bids_by(sort_key)
      sort_order = ''
      case sort_key
      when "created_at", "expires_at"
        sort_order = "DESC"

      when "price", "offers.price", "shipping", "users.username", "bid_type"
        sort_order = "ASC"

      else
        sort_order = "DESC"
      end
      order_by(sort_key, sort_order)
      
    end
    
  end


  def status
    if open?
      "open"
    elsif expired?
      "expired"
    elsif fullfilled?
      "fulfilled"
    elsif rejected?
      "rejected"
    else
      ""
    end
  end

  def open?
    !expired? && !fullfilled? && !rejected?
  end

  def expired?
    expires_at < Time.now && self.offer.expire_at < Time.now
  end

  def fullfilled?
    self.offer.fullfilled_at.present? && !expired? && !rejected?
  end

  def rejected?
    self.offer.canceled_at.present?
  end

  def get_type
    bid_type ? "countered" : "accepted"
  end

  def amount_to_merchant
    (PERCENT_TO_MERCHANT * total_amount).round(2)
  end

  def total_amount
    shipping? ? (price + shipping) : price
  end

  def get_description
    service.present? ? (service.brief_description) : (product.description)
  end

end


# == Schema Information
#
# Table name: bids
#
#  id         :integer(4)      not null, primary key
#  offer_id   :integer(4)
#  user_id    :integer(4)
#  price      :decimal(9, 2)
#  expires_at :datetime
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  shipping   :decimal(9, 2)
#

