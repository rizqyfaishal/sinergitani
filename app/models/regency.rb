class Regency < ApplicationRecord
  has_many :districts

  belongs_to :province
end
