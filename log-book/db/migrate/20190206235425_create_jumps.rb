class CreateJumps < ActiveRecord::Migration
  def change
    create_table :jumps do |t|
      t.integer :jump_number
      t.integer :altitude
      t.string :description
      t.integer :jumper_id
    end
  end
end
