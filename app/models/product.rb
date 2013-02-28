class Product < ActiveRecord::Base
  belongs_to :bid
  
end

# == Schema Information
#
# Table name: products
#
#  id                :integer(4)      not null, primary key
#  title             :string(255)
#  description       :text
#  brand             :string(255)
#  model             :string(255)
#  color             :string(255)
#  product_details   :text
#  technical_details :text
#  bid_id            :integer(4)
#  created_at        :datetime        not null
#  updated_at        :datetime        not null
#

