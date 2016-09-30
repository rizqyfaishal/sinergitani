class CreateRegencies < ActiveRecord::Migration[5.0]
  def up
    create_table :regencies do |t|
      t.string :name
      t.references :province
      t.timestamps
    end
    add_foreign_key :regencies, :provinces
  end

  def down
    remove_foreign_key :regencies, :provinces
    drop_table :regencies
  end
end
