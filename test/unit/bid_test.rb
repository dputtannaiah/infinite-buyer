require 'test_helper'

class BidTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
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

