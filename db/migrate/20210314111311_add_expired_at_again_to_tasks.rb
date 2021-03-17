class AddExpiredAtAgainToTasks < ActiveRecord::Migration[5.2]

  def change
    add_column :tasks, :expired_at, :datetime, null: false, default: -> { "CURRENT_TIMESTAMP" }
  end
end
