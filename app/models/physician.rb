class Physician < ApplicationRecord
  belongs_to :user
  has_many :appointments, dependent: :destroy
  has_many :patients, through: :appointments, dependent: :destroy
  accepts_nested_attributes_for :user

  has_one_attached :image
  
  # ransack_alias :user, :user_name_or_user_email_or_user_phone
end
