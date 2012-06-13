class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.column :country_code, "char(2)"
      t.string :country_name, :limit => 45
    end
    add_index :countries, :country_code, unique: true
  end
end
