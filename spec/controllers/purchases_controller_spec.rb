require 'spec_helper'

describe PurchasesController do

  describe "GET 'buy'" do
    it "returns http success" do
      get 'buy'
      response.should be_success
    end
  end

end
