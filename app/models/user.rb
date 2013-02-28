class User < ActiveRecord::Base
  extend OmniauthCallbacks

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :confirmable,
    :validatable, :token_authenticatable, :timeoutable,
    :omniauthable, :authentication_keys => [:login]

  USERNAME_MINIMUM_LENGTH = 6
  USERNAME_MAXIMUM_LENGTH = 65
  EMAIL_MAXIMUM_LOCAL_PART = 65

  PROVIDERS = ['facebook', 'twitter']

  attr_accessible :login, :username, :email, :password, :password_confirmation, :remember_me, :facebook_id, :twitter_id, :logged_in_as

  attr_accessor :login

  has_many :seller_categories, :dependent => :delete_all
  has_many :categories, :through => :seller_categories

  has_many :offers, :dependent => :destroy
  has_many :bids, :dependent => :destroy
  has_many :purchases, :dependent => :destroy
  has_many :declined_offers, :dependent => :destroy

  has_many :seller_offers, :dependent => :delete_all
  has_many :soffers, :through => :seller_offers, :foreign_key => :offer_id

  has_many :keywords, :dependent => :destroy
  has_many :accounts, :dependent => :destroy

  has_one :buyer_account, :dependent => :destroy
  has_one :seller_account, :dependent => :destroy

  validates :email, :format => {:with => /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/i,
    :message => 'Please enter valid email ID',
    :if => proc {|user| user.email.present? }
  }

  validates :email, :email => true
  validates :twitter_id, :facebook_id, :uniqueness => {:allow_nil => true, :allow_blank => true}

  validates :username, :uniqueness => true, :presence => true, :length => {:in => USERNAME_MINIMUM_LENGTH..USERNAME_MAXIMUM_LENGTH},
    :format => {:with => /\A[^\.-][^@&'\(\)<>]+[^\.]{2}\z/,
    :message => ' - Some special characters are not allowed',
    :if => proc { |u| u.username.present? && u.username.length > USERNAME_MINIMUM_LENGTH }},
    :username => true

  scope :sellers, proc {
    |category_query_string, keyword_query_string, zip, search_radius, and_or|
    where("id IN (SELECT user_id FROM seller_categories WHERE #{category_query_string}) #{keyword_query_string}
     #{and_or} id IN(SELECT user_id FROM accounts WHERE accounts.user_id = users.id AND accounts.type IN('SellerAccount') AND accounts.zip = ? AND accounts.search_radius <= ?)", zip, search_radius)
  }

  scope :matching_sellers, proc { |offer_id| find(:all, :conditions => ["id NOT IN(SELECT user_id FROM seller_offers WHERE users.id = seller_offers.user_id AND seller_offers.offer_id = ?)", offer_id]) }

  module LoggedInAs
    BUYER = 0
    SELLER = 1
    BOTH = 2
  end

  define_index do
    indexes keyword.text, :as => :keyword

    has categories(:id), :as => :category_id
    has seller_offers.offer_id, :as => :offer_id
    has seller_offers.user_id, :as => :user_id

    set_property :delta => true
    set_property :min_infix_len => 3
  end

  def set_logged_in_as session_logged_in_as
    if self.logged_in_as == LoggedInAs::BUYER and not session_logged_in_as == LoggedInAs::BUYER
      self.update_attribute :logged_in_as, LoggedInAs::BOTH
    elsif self.logged_in_as == LoggedInAs::SELLER and not session_logged_in_as == LoggedInAs::SELLER
      self.update_attribute :logged_in_as, LoggedInAs::BOTH
    elsif not self.logged_in_as
      self.update_attribute :logged_in_as, session_logged_in_as
    end
  end

  def admin?
    false
  end

  def username_email_present?
    !email.blank? && !username.blank?
  end

  def display_name pre_fix = nil, post_fix = nil
    first_name = !accounts.empty? && accounts.first.first_name.presence
    "#{pre_fix}#{first_name}#{post_fix}" if first_name
  end

  def both?
    logged_in_as == User::LoggedInAs::BOTH
  end

  def buyer?
    both? || logged_in_as == User::LoggedInAs::BUYER
  end

  def seller?
    both? || logged_in_as == User::LoggedInAs::SELLER
  end

  private
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end
  
end


# == Schema Information
#
# Table name: users
#
#  id                     :integer(4)      not null, primary key
#  email                  :string(255)     default(""), not null
#  encrypted_password     :string(255)     default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer(4)      default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  authentication_token   :string(255)
#  created_at             :datetime        not null
#  updated_at             :datetime        not null
#  username               :string(255)
#  logged_in_as           :integer(4)
#  twitter_id             :string(255)
#  facebook_id            :string(255)
#  delta                  :boolean(1)      default(TRUE), not null
#

