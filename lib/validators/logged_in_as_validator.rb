class LoggedInAsValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[:base] << "Please select one of the options, Buyer or Seller" if value.nil?
  end
end
