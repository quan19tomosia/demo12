class CreateAppointments < ActiveRecord::Migration[7.0]
  def change
    create_table :appointments do |t|
      t.references :physician
      t.references :patient
      t.references :service
      t.datetime :schedule, null: false
      t.text :diagnose
      t.integer :state, null: false, default: 0
      t.integer :rate
      t.text :comment
      t.text :note
      t.timestamps
    end
  end
end
