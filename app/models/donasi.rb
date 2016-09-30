class Donasi < ApplicationRecord
  belongs_to :funding
  belongs_to :donatur
end
