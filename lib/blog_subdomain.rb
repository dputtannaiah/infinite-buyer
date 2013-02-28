class BlogSubdomain
  def self.matches?(request)
    request.subdomain.present? && request.subdomain == 'blog' && request.subdomain != 'www' && Rails.env != 'testing'
  end
end