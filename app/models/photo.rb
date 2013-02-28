class Photo < ActiveRecord::Base
  belongs_to :bid
  belongs_to :user

  mount_uploader :image, PhotoUploader
end

# == Schema Information
#
# Table name: photos
#
#  id         :integer(4)      not null, primary key
#  image      :string(255)
#  bid_id     :integer(4)
#  user_id    :integer(4)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

