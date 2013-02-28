class Service < ActiveRecord::Base
  belongs_to :bid
end

# == Schema Information
#
# Table name: services
#
#  id                   :integer(4)      not null, primary key
#  brief_description    :text
#  detailed_description :text
#  additional_info      :text
#  bid_id               :integer(4)
#  created_at           :datetime        not null
#  updated_at           :datetime        not null
#

