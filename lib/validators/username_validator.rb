class UsernameValidator < ActiveModel::EachValidator
  DOMAINS = [".com", ".net", ".org", ".edu", "_com", "_net", "_org", "_edu",
    "-com", "-net", "-org", "-edu",'Infinite Buyer', 'Infinite.Buyer',
    'Infinite_Buyer', 'Infinite-Buyer']

  def validate_each(record, attribute, value)
    if value =~ Regexp.new(DOMAINS.join('|'))
      record.errors[attribute] << (options[:message] || "some domain name are not allowed")
    end
  end
end
