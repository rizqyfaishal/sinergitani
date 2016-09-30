class CreateDonasis < ActiveRecord::Migration[5.0]
  def up
    create_table :donasis do |t|
      t.decimal :amount
      t.references :funding, foreign_key: true

      t.timestamps
    end
  end

  def down
    remove_foreign_key :donasis, :fundings
    drop_table :donasis
  end
end
