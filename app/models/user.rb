class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :physician
  has_one :patient, dependent: :destroy
  has_many :messages

  enum role: {admin: 0, physician: 1, patient: 2}, _prefix: :role

  scope :all_except, ->(user) { where.not(id: user) }
end
