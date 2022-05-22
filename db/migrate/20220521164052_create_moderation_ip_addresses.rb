class CreateModerationIpAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :moderation_ip_addresses do |t|
      t.string :ip, null: false

      t.timestamps
    end
    add_index :moderation_ip_addresses, :ip, unique: true
  end
end
