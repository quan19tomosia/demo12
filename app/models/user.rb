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

  validates :name, presence: true

  after_commit :default_avatar, on: [:create]

  private
    def default_avatar
      avatar.attach(
        io: File.open(
          Rails.root.join(
            'app', 'assets', 'images', 'default_avatar.jpg'
          )
        ),
        filename: 'default_avatar.jpg',
        content_type: 'image/jpg'
      )
    end
end
