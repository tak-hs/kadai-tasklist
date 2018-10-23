class RenameTitleColumnToTasks < ActiveRecord::Migration[5.0]
  def change
    rename_column :tasks, :title, :status
  end
end
