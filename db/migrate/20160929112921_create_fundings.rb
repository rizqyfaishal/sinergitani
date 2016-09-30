class CreateFundings < ActiveRecord::Migration[5.0]
  def up
    create_table :fundings do |t|
      t.string :title
      t.decimal :total
      t.references :kelompok_tani, foreign_key: true
      t.date :deadline
      t.text :description
      t.timestamps
    end
  end

  def down
    remove_foreign_key :fundings, :kelompok_tanis
    drop_table :fundings
  end
end
