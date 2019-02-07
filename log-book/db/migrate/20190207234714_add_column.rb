class AddColumn < ActiveRecord::Migration
  def change
    add_column :user, :jump_id, :integer
  end
end
