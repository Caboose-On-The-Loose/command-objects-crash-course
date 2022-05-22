class AddKindToModerationAttempts < ActiveRecord::Migration[7.0]
  def change
    add_column :moderation_logs, :kind, :string, null: false
    add_column :moderation_logs, :thing_type, :string
    add_column :moderation_logs, :thing_id, :integer
    add_index :moderation_logs, :kind
    add_index :moderation_logs, [:thing_id, :thing_type]
  end
end
