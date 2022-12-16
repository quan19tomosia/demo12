class Room < ApplicationRecord
  has_many :messages

  scope :public_room, -> { where(is_private: false) }
end
