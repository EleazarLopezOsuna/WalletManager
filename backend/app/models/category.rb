class Category < ApplicationRecord
  belongs_to :type
  has_many :transactions
end
