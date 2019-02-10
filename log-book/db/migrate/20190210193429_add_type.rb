class AddType < ActiveRecord::Migration
  def change
    add_column :jumps, :type_of_jump, :string
  end
end
