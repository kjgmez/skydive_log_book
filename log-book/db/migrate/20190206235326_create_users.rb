class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :license
      t.integer :canopy_size
      t.timestamps null: false
    end
  end
end
