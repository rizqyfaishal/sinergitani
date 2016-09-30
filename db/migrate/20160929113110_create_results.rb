class CreateResults < ActiveRecord::Migration[5.0]
  def up
    create_table :results do |t|
      t.string :implementation
      t.string :result
      t.integer :increasing_number
      t.references :kelompok_tani, foreign_key: true
      t.timestamps
    end
  end

  def down
    remove_foreign_key :results, :kelompok_tanis
    drop_table :results
  end
end
