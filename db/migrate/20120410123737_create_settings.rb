class CreateSettings < ActiveRecord::Migration
  def self.up
    create_table :settings do |t|
      t.string :key_name
      t.string :key_value
      t.text :description

      t.timestamps
    end
    Setting.create :key_name => 'bid_expires_at', :key_value => "10",
                   :description => 'Specify the bid should be expired after its created. Should be given a number. Eg: 10. Which means bid expires after 10 days created.'
  end

  def self.down
    drop_table :settings
  end
end
