module AccountsHelper

  def account_type
    buyer? ? "buyer" : "seller"
  end

  def my_account(column_name)
    if current_user.buyer_account.present? && current_user.buyer_account.send(column_name).present? 
      current_user.buyer_account.send(column_name)
    elsif current_user.seller_account.present? && current_user.seller_account.send(column_name).present?
      current_user.seller_account.send(column_name)
    else
      ""
    end
  end

  def my_buyer_account(column_name)
    if current_user.buyer_account.present? && current_user.buyer_account.send(column_name).present?
      current_user.buyer_account.send(column_name)
    elsif current_user.seller_account.present? && current_user.seller_account.send(column_name).present?
      current_user.seller_account.send(column_name)
    else
      ""
    end
  end

  def my_seller_account(column_name)
    if current_user.seller_account.present? && current_user.seller_account.send(column_name).present?
      current_user.seller_account.send(column_name)
    elsif current_user.buyer_account.present? && current_user.buyer_account.send(column_name).present?
      current_user.buyer_account.send(column_name)
    else
      ""
    end
  end

  def buyer_active
    controller.action_name == 'edit_buyer' || controller.action_name == 'update_buyer' || controller.action_name == 'my_account' ? "active" : "ib-blk"
  end

  def seller_active
    controller.action_name == 'edit_seller' || controller.action_name == 'update_seller' ? "active" : "ib-blk"
  end

end
