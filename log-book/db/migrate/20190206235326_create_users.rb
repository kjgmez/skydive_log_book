class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :license
      t.integer :canopy_size

    end
  end
end