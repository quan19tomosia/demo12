class Room < ApplicationRecord
  has_many :messages

  scope :public_room, -> { where(is_private: false) }

  after_create_commit -> { broadcast_append_to "rooms", partial: "rooms/room", locals: { room: self }, target: "rooms" }
end
