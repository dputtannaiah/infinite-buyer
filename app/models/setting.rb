class Setting < ActiveRecord::Base
end

# == Schema Information
#
# Table name: settings
#
#  id          :integer(4)      not null, primary key
#  key_name    :string(255)
#  key_value   :string(255)
#  description :text
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

