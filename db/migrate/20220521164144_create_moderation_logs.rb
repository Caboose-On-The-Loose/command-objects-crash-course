class CreateModerationLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :moderation_logs do |t|
      t.string :type, null: false
      t.references :ip_address, null: false, foreign_key: { to_table: :moderation_ip_addresses }
      t.references :user_agent, null: false, foreign_key: { to_table: :moderation_user_agents }
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :moderation_logs, :type
  end
end
