class Offer < ActiveRecord::Base
  paginates_per 5
  #default_scope order("created_at DESC")
  #monetize :price

  belongs_to :user
  has_many :bids

  OFFER_TEXT_MAXIMUM_LENGTH = 100

  module Offer_type
    PRODUCT = 0
    SERVICE = 1
  end

  validates :text, :presence => true, :length => {:maximum => OFFER_TEXT_MAXIMUM_LENGTH }
  validates :price, :numericality => {:greater_than => 0}
  validates :search_radius, :zip, :presence => true, :numericality => true
  validates :price, :presence => true

  scope :open_offers, where("canceled_at IS NULL AND fullfilled_at IS NULL AND expire_at > ? ", Time.now)
  scope :other_offers, where("canceled_at IS NOT NULL OR fullfilled_at IS NOT NULL OR expire_at < ? ", Time.now)
  scope :declined_offers, proc { |current_user| where("id IN (SELECT offer_id FROM declined_offers WHERE offers.id = declined_offers.offer_id AND declined_offers.user_id = ?)", current_user.id) }
  scope :customized_order, proc {|sort_key, sort_order| order("#{sort_key.presence || 'created_at'} #{sort_order.presence || 'DESC'}")}
  scope :current_admin_offers, open_offers.where("id NOT IN (SELECT offer_id from seller_offers)")
  scope :history_admin_offers, open_offers.where("id IN (SELECT DISTINCT offer_id from seller_offers)")

  module STATUS
    OPEN = "open"
    EXPIRED = "expired"
    CANCELED = "canceled"
    EXPIRING = "expiring"
    FULLFILLED = "fullfilled"
  end

  after_create :customized_after_create

  def customized_after_create
    update_attribute :expire_at , created_at + 7.days
  end

  def cancel!
    self.update_attribute(:canceled_at, Time.now)
  end

  def get_status_class
    diff = (expire_at - Time.now)/(3600*24)
    new_diff = sprintf("%0.02f", diff).to_f
    if new_diff >= 3.0
      color_class='green'
    elsif (new_diff > 1.0 && new_diff <= 2.99)
      color_class = 'yellow'
    elsif new_diff <= 1.0
      color_class = 'red'
    end
    color_class
  end

  def get_offer_status
    if canceled_at?
      return Offer::STATUS::CANCELED
    elsif fullfilled_at?
      return Offer::STATUS::FULLFILLED
    elsif expire_at < Time.now
      if self.expired_at.blank?
        self.expired_at = self.expire_at
        save
      end
      return Offer::STATUS::EXPIRED
    end

    diff = (expire_at - Time.now)/(3600*24)
    new_diff = sprintf("%0.02f", diff).to_f

    if new_diff >= 3.0
      Offer::STATUS::OPEN
    elsif (new_diff > 1.0 && new_diff <= 2.99)
      Offer::STATUS::OPEN
    elsif new_diff <= 1.0
      Offer::STATUS::EXPIRING
    end
  end

  def accepted_offers_count
    self.bids.where("ROUND(price) = ROUND(?)", self.price).count
  end

  def counter_offers_count
    self.bids.where("ROUND(price) <> ROUND(?)", self.price).count
  end

  def get_status_and_mail
    diff = (expire_at - Time.now)/3600
    new_diff = sprintf("%0.02f", diff).to_f
    if new_diff > 24.00 && new_diff <= 48.00 && expiry_email_sent_48 == false
      Notifier.offer_notice(self, new_diff.round).deliver
      self.expiry_email_sent_48 = true
      save(:validate => false)
    elsif new_diff > 1.00 && new_diff <= 24.00 && expiry_email_sent_24 == false
      Notifier.offer_notice(self, new_diff.round).deliver
      self.expiry_email_sent_24 = true
      save(:validate => false)
    end
  end

  #TODO
  #HACK
  def open_at
    Time.now
  end

  def expiring_at
    Time.now + 1
  end

  class << self

    def my_offers(current_user) # Offers for sellers
      open_offers.where("id IN (SELECT offer_id FROM seller_offers WHERE seller_offers.offer_id = offers.id AND seller_offers.user_id= ?)",
        current_user.id).where("id NOT IN(?) AND id NOT IN(?)",
        current_user.bids.map(&:offer_id).presence || [-1], current_user.declined_offers.map(&:offer_id).presence || [-1])
    end

    def offer_notifications
      open_offers.each do |offer|
        offer.get_status_and_mail
      end
    end
  end
end



# == Schema Information
#
# Table name: offers
#
#  id            :integer(4)      not null, primary key
#  text          :string(255)
#  user_id       :integer(4)
#  price         :decimal(9, 2)
#  search_radius :integer(4)
#  zip           :integer(4)
#  created_at    :datetime
#  updated_at    :datetime
#  expire_at     :datetime
#  status        :string(10)
#  canceled_at   :datetime
#  fullfilled_at :datetime
#  expired_at    :datetime
#  offer_type    :integer(4)      default(0)
#

