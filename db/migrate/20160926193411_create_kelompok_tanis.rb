class CreateKelompokTanis < ActiveRecord::Migration[5.0]
  def up
    create_table :kelompok_tanis do |t|
      t.string :name
      t.string :group_name
      t.string :email
      t.string :phone
      t.string :password_digest
      t.references :province, foreign_key: true
      t.references :regency, foreign_key: true
      t.references :district, foreign_key: true
      t.references :village, foreign_key: true
      t.timestamps
    end
  end

  def down
    remove_foreign_key :kelompok_tanis, :villages
    remove_foreign_key :kelompok_tanis, :districts
    remove_foreign_key :kelompok_tanis, :regencies
    remove_foreign_key :kelompok_tanis, :provinces
    drop_table :kelompok_tanis
  end
end
