class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :lockable, :confirmable
  has_one :physician, dependent: :destroy
  has_one :patient, dependent: :destroy
  has_many :messages

  has_one_attached :avatar

  enum role: {admin: 0, physician: 1, patient: 2}, _prefix: :role

  scope :all_except, ->(user) { where.not(id: user) }

end
