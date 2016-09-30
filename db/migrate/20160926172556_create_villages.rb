class CreateVillages < ActiveRecord::Migration[5.0]
  def up
    create_table :villages do |t|
      t.string :name
      t.references :district, foreign_key: true
      t.timestamps
    end
  end

  def down
    remove_foreign_key :villages, :districts
    drop_table :villages
  end
end
