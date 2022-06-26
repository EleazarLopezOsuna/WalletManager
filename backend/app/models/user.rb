class User < ApplicationRecord
  has_many :wallets
  validates :name, presence: true
  validates :password, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }

end
