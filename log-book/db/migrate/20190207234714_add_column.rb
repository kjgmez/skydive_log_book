class AddColumn < ActiveRecord::Migration
  def change
    add_column :users, :jump_id, :integer
  end
end
