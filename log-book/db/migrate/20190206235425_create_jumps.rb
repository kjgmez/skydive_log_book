class CreateJumps < ActiveRecord::Migration
  def change
    create_table :jumps do |t|

      t.timestamps null: false
    end
  end
end
