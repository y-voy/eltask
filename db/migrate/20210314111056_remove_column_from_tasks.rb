class RemoveColumnFromTasks < ActiveRecord::Migration[5.2]
  def change
    remove_column :tasks, :expired_at
  end
end
