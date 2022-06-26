class Category < ApplicationRecord
  belongs_to :type
  has_many :transactions
  validate :save_object?

  def save_object?
    type = Type.find_by id: self.type_id
    unless type.nil?
      return false
    end
  end
end
