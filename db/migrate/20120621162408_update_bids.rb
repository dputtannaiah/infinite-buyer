class UpdateBids < ActiveRecord::Migration
  def up
    Bid.all.each do |bid|
      if bid.present? && bid.offer.present?
        bid.price == bid.offer.price ? (bid.bid_type = 0) : (bid.bid_type = 1)
        bid.save(:validate => false)
      end
    end
  end

  def down
  end
end
