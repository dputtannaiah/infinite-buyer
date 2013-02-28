require 'sanitize'

class Keyword < ActiveRecord::Base

  validates :user_id, :presence => true

  belongs_to :user
  belongs_to :category

  before_save do
    self.text = Sanitize.clean text
    self.negative_text = Sanitize.clean negative_text
  end

  after_save :update_sphinx

  module KeywordStatus
    Active = 1
    Passive = 0
  end

  class << self
    def assign_keywords(category_keywords, category_id,user)
      user.keywords = []
      category_keywords.each_pair do |key, value|
        if value.present?
          status = category_id.include?(key) ? (KeywordStatus::Active) : (KeywordStatus::Passive)
          user.keywords.create(:category_id => key, :text => value, :status => status)
        end
      end
    end

    def category_keywords(category_ids)
      @fashion = find_by_category_id(category_ids[:fashion])
      @electronics = find_by_category_id(category_ids[:electronics])
      @cooking = find_by_category_id(category_ids[:cooking])
      @product_home = find_by_category_id(category_ids[:product_home])
      @sporting_goods = find_by_category_id(category_ids[:sporting_goods])

      @automotive = find_by_category_id(category_ids[:automotive])
      @service_home = find_by_category_id(category_ids[:service_home])
      @personal = find_by_category_id(category_ids[:personal])
      @professional = find_by_category_id(category_ids[:professional])
    end

    def keywords_text(category_ids)
      text = {:fashion => '', :electronics => '', :cookikng => '', :product_home => '',
        :sporting_goods => '', :automotive => '', :service_home => '',
        :personal => '', :professional => '' }
      
      negative_text = {:fashion => '', :electronics => '', :cookikng => '', 
        :product_home => '', :sporting_goods => '', :automotive => '', :service_home => '',
        :personal => '', :professional => '' }

      keywords = {:text => text, :negative_text => negative_text }

      category_keywords(category_ids)

      keywords[:text][:fashion] = @fashion.text if @fashion.present?
      keywords[:text][:electronics] = @electronics.text if @electronics.present?
      keywords[:text][:cooking] = @cooking.text if @cooking.present?
      keywords[:text][:product_home] = @product_home.text if @product_home.present?
      keywords[:text][:sporting_goods] = @sporting_goods.text if @sporting_goods.present?
      keywords[:text][:automotive] = @automotive.text if @automotive.present?
      keywords[:text][:service_home] = @service_home.text if @service_home.present?
      keywords[:text][:personal] = @personal.text if @personal.present?
      keywords[:text][:professional] = @professional.text if @professional.present?

      
      keywords[:negative_text][:fashion] = @fashion.negative_text if @fashion.present?
      keywords[:negative_text][:electronics] = @electronics.negative_text if @electronics.present?
      keywords[:negative_text][:cooking] = @cooking.negative_text if @cooking.present?
      keywords[:negative_text][:product_home] = @product_home.negative_text if @product_home.present?
      keywords[:negative_text][:sporting_goods] = @sporting_goods.negative_text if @sporting_goods.present?

      keywords[:negative_text][:automotive] = @automotive.negative_text if @automotive.present?
      keywords[:negative_text][:service_home] = @service_home.negative_text if @service_home.present?
      keywords[:negative_text][:personal] = @personal.negative_text if @personal.present?
      keywords[:negative_text][:professional] = @professional.negative_text if @professional.present?

      keywords
    end

  end


  private
  def update_sphinx
    user.save
  end
end


# == Schema Information
#
# Table name: keywords
#
#  id            :integer(4)      not null, primary key
#  text          :text
#  user_id       :integer(4)
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#  negative_text :text
#  category_id   :integer(4)
#

