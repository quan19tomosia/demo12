class CreateServices < ActiveRecord::Migration[7.0]
  def change
    create_table :services do |t|
      t.string :name, null: false
      t.text :description
      t.integer :price
      t.integer :status, null: false, default: 0
      t.timestamps
    end
  end
end
