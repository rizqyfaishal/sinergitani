class Donatur < ApplicationRecord
  has_secure_password

  has_many :donasis, :as => :donasi
end
