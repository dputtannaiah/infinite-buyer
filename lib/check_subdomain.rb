class CheckSubdomain
  def self.matches?(request)
    request.subdomain.present? && request.subdomain == 'blog' && request.subdomain != 'www' && Rails.env != 'testing'
    request_path = request.env['action_dispatch.request.path_parameters']
    unless(request_path[:controller] == 'blog/posts' && request_path[:action] == 'index') || (request_path[:controller] == 'blog/posts' && request_path[:action] == 'show') || (request_path[:controller] == 'blog/comments' && request_path[:action] == 'create')
      request.env['HTTP_HOST'] = request.env['HTTP_HOST'].sub("blog.","")
    end
  end
end