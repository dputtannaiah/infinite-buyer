module General
  def get_selected_sort_key(sort_key)
    case sort_key
    when "created_at"
      ['Most Recent', 'created_at']
    when 'username'
      ['Buyer User ID', 'username']
    when 'text'
      ['Description', 'text']
    when 'price'
      ['Buyer Offer','price']
    else
      false
    end
  
  end
end
