class Account < ActiveRecord::Base
  attr_accessor :phone, :validate_phone

  validates :user_id,
    :presence => true,
    :numericality => true
  #:uniqueness => true


  validates :last_name,
    :presence => true, 
    :length => {:in => 2...40,
    :if => proc { |account| account.last_name.present? }},
    :format => {:with => /^[a-zA-Z0-9_\. ]+$/,
    :message => ' is not valid',
    :if => proc { |account| account.last_name.present? }}

  validates :first_name,
    :presence => true, :length => {:in => 2...40,
    :if => proc { |account| account.first_name.present? }},
    :format => {:with => /^[a-zA-Z0-9_\. ]+$/,
    :message => ' is not valid',
    :if => proc { |account| account.first_name.present? }}

  validates :zip,
    :presence => true,
    :format => {:with => /^[0-9][0-9][0-9][0-9][0-9]$/,
    :message => "Please enter valid Zip Code",
    :if => proc { |account| account.zip.present? }}

  validates :terms_of_service, :acceptance => true

  validate :custom_validation

  belongs_to :user

  def custom_validation
    if phone.present? && !phone.match(/^\(?([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})$/)
      errors.add(:phone, "not a valid phone number.")
    end
  end

  def phone
    (phone1 + phone2 + phone3) if (phone1.present? && phone2.present? && phone3.present?)
  end

  def get_account_type(session)
    session == User::LoggedInAs::BUYER ? "buyer" : "seller"
  end

  class << self
    def radii
      [5, 10, 15, 25, 50, 75, 100, 200, 500, 1000, 2000].sort
    end

    def all_states
      ["Alabama", "Alaska", "Arizona", "Arkansas", "California", "Colorado", "Connecticut", "Delaware",
        "Florida", "Georgia", "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky",
        "Louisiana", "Maine", "Maryland", "Massachusetts", "Michigan", "Minnesota", "Mississippi", "Missouri",
        "Montana", "Nebraska", "Nevada", "New Hampshire", "New Jersey", "New Mexico", "New York",
        "North Carolina", "North Dakota", "Ohio", "Oklahoma", "Oregon", "Pennsylvania",
        "Rhode Island", "South Carolina", "South Dakota", "Tennessee", "Texas", "Utah", "Vermont",
        "Virginia", "Washington", "West Virginia", "Wisconsin", "Wyoming"].sort
    end

    def all_security_questions
      ["What was the first concert you attended?", "What is your mother's maiden name?",
        "What was the name of your first pet?", "What is the name of your first school?",
        "What is the name of your favorite school teacher?"].sort
    end

    def account_type
      ["Buyer", "Seller", "Both"]
    end

  end

end



# == Schema Information
#
# Table name: accounts
#
#  id               :integer(4)      not null, primary key
#  first_name       :string(255)     not null
#  last_name        :string(255)     not null
#  address          :string(255)
#  city             :string(255)
#  state            :string(255)
#  zip              :integer(4)      not null
#  search_radius    :integer(4)      not null
#  user_id          :integer(4)      not null
#  created_at       :datetime        not null
#  updated_at       :datetime        not null
#  company          :string(255)
#  apt_suite_others :string(255)
#  phone1           :string(255)
#  phone2           :string(255)
#  phone3           :string(255)
#  type             :string(255)
#  paypal_email     :string(255)
#

