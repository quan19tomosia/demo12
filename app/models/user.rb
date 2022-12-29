class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :lockable, :confirmable
  has_one :physician, dependent: :destroy
  has_one :patient, dependent: :destroy
  has_many :messages, dependent: :destroy

  has_one_attached :avatar, dependent: :destroy

  enum role: {admin: 0, physician: 1, patient: 2}, _prefix: :role

  scope :all_except, ->(user) { where.not(id: user) }

  validates :name, presence: true

  before_create :default_avatar

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

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
