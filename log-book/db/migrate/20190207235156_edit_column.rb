class EditColumn < ActiveRecord::Migration
  def change
    rename_column :jumps, :jumper_id, :user_id
  end
end
