require 'test_helper'

class OfferTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
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

