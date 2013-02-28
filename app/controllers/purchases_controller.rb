class PurchasesController < ApplicationController
  before_filter :authenticate_user!, :only => [:buy]
  skip_before_filter :user_seller_account?, :only => [:buy]

  def buy
    @bid = Bid.find params[:id]
    @offer = @bid.offer
    purchase = current_user.purchases.create! :bid_id => @bid.id
    pay_request = PaypalAdaptive::Request.new
    data = {"returnUrl" => offer_bids_url(@offer),
      "requestEnvelope" => {"errorLanguage" => "en_US"},
      "currencyCode" => "USD",
      "receiverList" =>
        {"receiver" => [
          {"email" => @bid.user.seller_account.paypal_email, "amount" => @bid.total_amount, "primary" => true},
          {"email" => configatron.paypal.merchant, "amount" => @bid.amount_to_merchant, "primary" => false}
        ]},
      "cancelUrl" => offer_bids_url(@offer),
      "actionType" => "PAY",
      "ipnNotificationUrl" => ipn_notification_purchases_url(:purchase_id => purchase.id, :offer_id => @offer.id, :bid_id => @bid.id)}

    pay_response = pay_request.pay data
    purchase.update_attributes :params => pay_response
    if pay_response.success?
      redirect_to pay_response.approve_paypal_payment_url
    else
      flash[:notice] = pay_response.errors.first['message']
      redirect_to offer_bids_path(@offer)
    end
  end

  #PAYPAL returns this
  #{"transaction" => {"0" => {".is_primary_receiver" => "true", ".id_for_sender_txn" => "89M359909M9841337",
  #                           ".receiver" => "sadiga_1337618523_per@qwinixtech.com", ".amount" => "USD 9.40",
  #                           ".status" => "Completed", ".id" => "4XE46635H53215922",
  #                           ".status_for_sender_txn" => "Completed", ".paymentType" => "SERVICE", ".pending_reason" => "NONE"},
  #                   "1" => {".paymentType" => "SERVICE",
  #                           ".id_for_sender_txn" =>
  #                               "03227576D45362422", ".is_primary_receiver" => "false", ".status_for_sender_txn" =>
  #                           "Completed", ".receiver" => "sadiga_1337619102_biz@qwinixtech.com", ".amount" => "USD 0.60",
  #                           ".pending_reason" => "NONE", ".id" => "2A12292507315634U", ".status" => "Completed"}},
  # "log_default_shipping_address_in_transaction" => "false", "action_type" => "PAY",
  # "ipn_notification_url" => "http://ib.qwinixtech.com/purchases/ipn_notification", "charset" => "windows-1252",
  # "transaction_type" => "Adaptive Payment PAY", "notify_version" => "UNVERSIONED",
  # "cancel_url" => "http://ib.qwinixtech.com/offers/64/bids",
  # "verify_sign" => "AFcWxV21C7fd0v3bYYYRCpSSRl31AT7zfMkB.c7dJX5sxFm.mfLLGVVT",
  # "sender_email" => "sadiga_1339093284_per@qwinixtech.com", "fees_payer" => "EACHRECEIVER",
  # "return_url" => "http://ib.qwinixtech.com/offers/64/bids", "reverse_all_parallel_payments_on_error" => "false",
  # "pay_key" => "AP-8KD976200B893350Y", "status" => "COMPLETED", "test_ipn" => "1",
  # "payment_request_date" => "Thu Jun 07 12:29:14 PDT 2012"}

  def ipn_notification
    ipn = PaypalAdaptive::IpnNotification.new
    ipn.send_back(request.raw_post)

    @purchase = Purchase.find(params[:purchase_id])
    if ipn.verified?
      @offer = Offer.find(params[:offer_id])
      @bid = Bid.find(params[:bid_id])

      @purchase.touch :purchased_at
      @offer.update_attribute(:fullfilled_at, Time.now)
      Notifier.buyer_purchase_buyer(@offer, @bid).deliver
      Notifier.buyer_purchase_seller(@offer, @bid).deliver
    end
    @purchase.update_attributes :ipn_notification_params => params

    render :nothing => true
  end
end
