class CreateTimeZones < ActiveRecord::Migration
  def change
    create_table :time_zones do |t|
      t.boolean    :dst,          null: false
      t.integer    :gmt_offset,   null: false
      t.integer    :time_start,   null: false
      t.references :zone
      t.string     :abbreviation, null: false, limit: 6
    end
    add_index :time_zones, :time_start
  end
end
