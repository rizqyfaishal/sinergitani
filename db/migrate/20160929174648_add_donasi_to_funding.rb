class AddDonasiToFunding < ActiveRecord::Migration[5.0]
  def change
    add_reference :fundings, :donasi, foreign_key: true
  end
end
