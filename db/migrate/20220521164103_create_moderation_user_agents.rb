class CreateModerationUserAgents < ActiveRecord::Migration[7.0]
  def change
    create_table :moderation_user_agents do |t|
      t.string :name, null: false

      t.timestamps
    end
    add_index :moderation_user_agents, :name, unique: true
  end
end
