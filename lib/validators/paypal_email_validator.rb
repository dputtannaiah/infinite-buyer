class PaypalEmailValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)

    if value.present? && value.split('@').first.length > User::EMAIL_MAXIMUM_LOCAL_PART
      record.errors[:base] << (options[:message] || "Local part of the email cannot exceed #{User::EMAIL_MAXIMUM_LOCAL_PART} characters")
    end
  end
end