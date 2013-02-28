class SellerAccount < Account
  belongs_to :user

  validates :phone1, :phone2, :phone3, :presence => true, :numericality => true
  validates :paypal_email, :presence => true
  validates :paypal_email, :format => {:with => /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/i,
    :message => 'Please enter valid paypal email ID.',
    :if => proc {|account| account.paypal_email.present?}}

  validates :company, :format => {:with => /^[a-zA-Z0-9]+(.){0,}$/i,
    :message => ' name is not valid',
    :if => proc {|account| account.company.present? }}
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

