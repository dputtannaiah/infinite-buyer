class Purchase < ActiveRecord::Base
  serialize :params

  validates :user_id, :bid_id, :presence => true

  belongs_to :user
  belongs_to :bid
end


# == Schema Information
#
# Table name: purchases
#
#  id                      :integer(4)      not null, primary key
#  amount                  :float
#  user_id                 :integer(4)
#  bid_id                  :integer(4)
#  params                  :text
#  purchased_at            :datetime
#  created_at              :datetime        not null
#  updated_at              :datetime        not null
#  ipn_notification_params :text
#

