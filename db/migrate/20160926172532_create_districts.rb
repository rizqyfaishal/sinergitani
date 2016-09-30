class CreateDistricts < ActiveRecord::Migration[5.0]
  def up
    create_table :districts do |t|
      t.string :name
      t.references :regency, foreign_key: true
      t.timestamps
    end
  end

  def down
    remove_foreign_key :districts, :regencies
    drop_table :districts
  end
end
