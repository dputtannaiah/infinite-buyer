class Admins::UnlocksController < Devise::UnlocksController
skip_before_filter :set_logged_in_as_session, :user_email_and_username?, :user_seller_account?, :user_buyer_account?, :user_phone?, :user_category?
end