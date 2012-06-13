class CreateZones < ActiveRecord::Migration
  def change
    create_table :zones do |t|
      t.references :country
      t.string :zone_name, null: false, limit: 35
    end
    add_index :zones, :zone_name, unique: true
  end
end
