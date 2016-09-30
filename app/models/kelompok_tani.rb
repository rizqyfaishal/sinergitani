class KelompokTani < ApplicationRecord

  has_secure_password

  belongs_to :province
  belongs_to :regency
  belongs_to :district
  belongs_to :village

  has_one :funding
end
