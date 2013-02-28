module BidsHelper

  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association,new_object,:child_index => "new_#{association}") do |builder|
      render :partial => association.to_s.singularize + "_fields", :locals => {:f => builder}
    end
    link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
  end

  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)", :class => 'link-to-remove')
  end

  def customized_bid_path(offer)
    offer.offer_type == Offer::Offer_type::PRODUCT ? new_offer_bid_path(offer) : new_service_path(offer)
  end

  def product_or_service_path(bid)
    bid.offer.offer_type == Offer::Offer_type::PRODUCT ? product_details_path(bid) : service_details_path(bid)
  end

  def purchase_status(bid, purchased_bid)
    bid.id == purchased_bid.id ? ("fullfilled #{bid.offer.fullfilled_at.strftime('%m %d %Y') if bid.offer.fullfilled_at.present?}") : ''
  end

  def offer_status(offer)
    offer.get_offer_status =~ /fullfilled/i
  end

end
