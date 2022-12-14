class CreatePhysicians < ActiveRecord::Migration[7.0]
  def change
    create_table :physicians do |t|
      t.references :user
      t.string :degree
      t.string :education
      t.string :speciality
      t.text :experience
      t.text :about
      t.timestamps
    end
  end
end
