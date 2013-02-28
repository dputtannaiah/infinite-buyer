module PostsHelper
  def get_blog_url
    Rails.env == 'testing' ? blog_posts_url : root_url(:subdomain => 'blog')
  end
end
