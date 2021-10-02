class CreateSecondarySchools < ActiveRecord::Migration[6.1]
  def change
    create_table :secondary_schools do |t|
      t.string :address
      t.st_point :lonlat, geographic: true
      t.string :name
      t.bigint :unit_id

      t.timestamps
    end
    add_index :secondary_schools, :lonlat, using: :gist
  end
end
