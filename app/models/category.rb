class Category < ActiveRecord::Base
  acts_as_paranoid
  has_ancestry

  validates :name, :presence => true, :uniqueness => {:scope => [:ancestry]}

  has_one :keyword

  module CategoryType
    PRODUCT = 0
    SERVICE = 1
  end

  class << self
    def get_query_string(category_ids)
      query_string = []
      category_ids.each do |category_id|
        query_string << "seller_categories.category_id = #{category_id} OR "
      end
      query_string.last.gsub!("OR", '')
      query_string.join('')
    end

    def has_unique_category_type?(category_ids)
      status = true
      categories = find(category_ids)
      for i in 0..(categories.length - 2)
        categories[i].root == categories[i+1].root ? (status = true) : (status = false; break;)
      end
      status
    end

    def get_keyword_query_string(category_ids, keyword)
      negative_keyword = "AND keywords.negative_text not like '%#{keyword}%'"
      query_string = ["AND id IN(SELECT user_id FROM keywords WHERE users.id = keywords.user_id AND "]

      category_ids.each do |category_id|
        @category = find(category_id)
        (@category.path.count - 2).times do
          @category = @category.parent
        end
        query_string << "keywords.category_id = #{@category.id} AND keywords.text like '%#{keyword}%' #{negative_keyword} OR "
      end
      query_string.last.gsub!("OR", ')')
      query_string.join('')
    end

    def category_ids
      category_ids = {:fashion => '', :electronics => '', :cookikng => '', :product_home => '',
        :sporting_goods => '', :automotive => '', :service_home => '',
        :personal => '', :professional => '', :collectibiles => '', :jewellery => ''
      }
      
      category_ids[:fashion] = find_by_name("Fashion").id
      category_ids[:electronics] = find_by_name("Electronics").id
      category_ids[:cooking] = find_by_name("Cooking").id
      category_ids[:sporting_goods] = find_by_name("Sporting Goods").id
      category_ids[:automotive] = find_by_name("automotive").id
      category_ids[:personal] = find_by_name("Personal").id
      category_ids[:professional] = find_by_name("Professional").id
      category_ids[:collectibiles] = find_by_name("Collectibiles").id
      category_ids[:jewellery] = find_by_name("Jewellery").id

      services = Category.find_by_name("Services")
      products = Category.find_by_name("Products")
      category_ids[:service_home] = services.children.find_by_name("Home").id
      category_ids[:product_home] = products.children.find_by_name("Product_Home").id
      category_ids
    end

  end

  def product?
    category_type == CategoryType::PRODUCT
  end

  def service?
    category_type == CategoryType::SERVICE
  end

end


# == Schema Information
#
# Table name: categories
#
#  id            :integer(4)      not null, primary key
#  name          :string(255)
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#  ancestry      :string(255)
#  category_type :integer(2)      default(0)
#

