class User < ApplicationRecord
  has_secure_password
  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_flicks, through: :favorites, source: :flick

  before_save :format_username, :format_email

  validates :name, presence: true

  validates :username, presence: true, uniqueness: { case_sensitive: false },
            format: {
              with: /\A[A-Z0-9]+\z/i
            }

  validates :email, presence: true, uniqueness: { case_sensitive: false },
            format: {
              with: /\S+@\S+/,
              on: [:create, :new]
            }

  validates :password, length: { minimum: 10, allow_blank: true }

  scope :by_name, -> { order(name: :asc) }
  scope :regular_users, -> { by_name.where(admin: false) }
  scope :admins, -> { by_name.where(admin: true) }

  def gravatar_id
    Digest::MD5::hexdigest(email.downcase)
  end

  def to_param
    self.username
  end

  private

  def format_username
    self.username = username.downcase
  end

  def format_email
    self.email = email.downcase
  end

end
