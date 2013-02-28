class AddColumnIpnNotificationParamsToPurchases < ActiveRecord::Migration
  def change
    add_column :purchases, :ipn_notification_params, :text
  end
end
