class ExpiresAtValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    if value.present? && value > record.offer.expire_at
      record.errors[:base] << (options[:message] || "Seller Expiry Date should be less than or equal to Buyer Expiry Date(#{record.offer.expire_at.strftime('%m/%d/%Y') if record.offer.present?})")
    end
  end
end