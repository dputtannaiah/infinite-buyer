class SuperAdmins::OffersController < InheritedResources::Base
  before_filter :authenticate_super_admin!

  def search
    return unless request.post?
    @offers = Offer
    @offers = @offers.where("created_at >= '#{params[:created_at_greater_than]} 00:00:00'") if params[:created_at_greater_than].present?
    @offers = @offers.where("created_at <= '#{params[:created_at_less_than]} 23:59:59'") if params[:created_at_less_than].present?
    @offers = @offers.page(params[:page])
    flash[:notice] = "No offers found." if @offers.blank?
  end

  protected
  def collection
    @offers ||= end_of_association_chain.page(params[:page])
  end
end