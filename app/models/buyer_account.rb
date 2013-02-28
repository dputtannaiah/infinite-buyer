class BuyerAccount < Account
  belongs_to :user
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

