class Funding < ApplicationRecord
  belongs_to :kelompok_tani
  has_many :donasis,:as => :donasi
end
