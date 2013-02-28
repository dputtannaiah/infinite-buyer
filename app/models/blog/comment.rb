class Blog::Comment < ActiveRecord::Base
  default_scope :order => 'created_at DESC'

  validates :post_id, :body, :name, :presence => true
  validates :email, :presence => true,
            :format => {:with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i}

  belongs_to :admin
  belongs_to :post

  before_save :sanitize_body

  scope :reviewed, where("reviewed_at is not NULL")

  def sanitize_body
    Rails.logger.info "sanitizing ..."
    self.body = Sanitize.clean(body,
                               :elements=> ['strong', 'ul', 'li', 'p', 'ol', 'br', 'span', 'em'],
                               :attributes=> {'span' => ['style']})
  end

end

# == Schema Information
#
# Table name: blog_comments
#
#  id         :integer(4)      not null, primary key
#  user_id    :integer(4)
#  body       :text
#  post_id    :integer(4)
#  created_at :datetime
#  updated_at :datetime
#  name       :string(255)
#  website    :string(255)
#  email      :string(255)
#

