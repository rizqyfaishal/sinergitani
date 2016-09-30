class AddDonaturToDonasi < ActiveRecord::Migration[5.0]
  def change
    add_reference :donasis, :donatur, foreign_key: true
  end
end
