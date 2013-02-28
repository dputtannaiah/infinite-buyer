module Admins
  class OffersController < ApplicationController
    layout "bootstrap"

    def comments
      @offer = Offer.find params[:id]
    end
  end
end