class Blog::Post < ActiveRecord::Base
  include TruncateHtmlHelper
  mount_uploader :avatar, BlogPostUploader
  paginates_per 10

  default_scope :order => 'created_at DESC'

  extend FriendlyId
  friendly_id :title, use: :slugged

  validates :title, :body, :presence => true

  scope :popular, where("deleted_at is NULL").order('views DESC')
  scope :between_dates, lambda { |start_date, end_date| where("created_at >= '#{start_date.to_s}' and created_at <= '#{end_date.to_s}' and deleted_at is NULL") }

  has_many :comments
  belongs_to :admin

  before_save :sanitize_body

  def sanitize_body
    Rails.logger.info "sanitizing ..."
    self.body = Sanitize.clean(body,
                               :elements => ['strong', 'ul', 'li', 'p', 'ol', 'br', 'span', 'em'],
                               :attributes => {'span' => ['style']})
  end

  def self.archives start_date = "2011-01-01".to_date
    current_month = start_date
    dates = []
    while current_month < Date.today
      current_month = current_month.next_month
      dates << current_month unless self.between_dates(current_month.to_s, current_month.end_of_month.to_s).count.zero?
    end
    dates
  end

  def truncated_body
    truncate_html(body, :length => 700, :omission => '.....')
  end

  def update_views
    self.views = self.views.to_i + 1
    self.save
  end

  def deactivate!
    self.deleted_at = Time.zone.now
    self.save
  end

  def activate!
    self.deleted_at = nil
    self.save
  end

  def status
    deleted_at.blank? ? "Active" : "<span style='color:red'>Inactive</span>"
  end

  def active?
    deleted_at.blank?
  end
end

# == Schema Information
#
# Table name: blog_posts
#
#  id         :integer(4)      not null, primary key
#  admin_id   :integer(4)
#  body       :text
#  title      :string(255)
#  created_at :datetime
#  updated_at :datetime
#  views      :integer(4)
#  deleted_at :datetime
#  avatar     :string(255)
#  permalink  :string(255)
#  slug       :string(255)
#

