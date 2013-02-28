class DeclinedOffer < ActiveRecord::Base

  validates :offer_id, :user_id, :presence => true, :numericality => true
end

# == Schema Information
#
# Table name: declined_offers
#
#  id         :integer(4)      not null, primary key
#  offer_id   :integer(4)
#  user_id    :integer(4)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

