class SellerOffer < ActiveRecord::Base

  belongs_to :user
  belongs_to :offer
  
  after_save :update_sphinx

  private

  def update_sphinx
    user.save
  end
end

# == Schema Information
#
# Table name: seller_offers
#
#  id         :integer(4)      not null, primary key
#  offer_id   :integer(4)
#  user_id    :integer(4)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

