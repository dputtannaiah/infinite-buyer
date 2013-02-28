class SellerCategory < ActiveRecord::Base
  belongs_to :category
  belongs_to :user

  after_save :update_sphinx

  private

  def update_sphinx
    user.save
  end
end

# == Schema Information
#
# Table name: seller_categories
#
#  id          :integer(4)      not null, primary key
#  user_id     :integer(4)
#  category_id :integer(4)
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

