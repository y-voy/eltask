class ChangeTaskNameAndDescriptionNotNull < ActiveRecord::Migration[5.2]
  def up
    change_column_null :tasks, :name, false
    change_column_null :tasks, :description, false
  end
end
