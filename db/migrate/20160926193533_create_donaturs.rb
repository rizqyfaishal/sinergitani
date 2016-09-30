class CreateDonaturs < ActiveRecord::Migration[5.0]
  def up
    create_table :donaturs do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :phone
      t.timestamps
    end
  end

  def down
    drop_table :donaturs
  end
end
