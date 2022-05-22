class RemoveKindConstraint < ActiveRecord::Migration[7.0]
  def change
    change_column_null :moderation_logs, :kind, true
  end
end
