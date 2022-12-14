class Physician < ApplicationRecord
  belongs_to :user
  # has_one_attached :picture
  has_many :appointments, dependent: :destroy
  has_many :patients, through: :appointments, dependent: :destroy
end
