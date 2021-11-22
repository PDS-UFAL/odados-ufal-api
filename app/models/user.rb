class User < ApplicationRecord
  has_secure_password

  belongs_to :sector, optional: true

  EMAIL_REGEX = /[^@ \t\r\n]+@[^@ \t\r\n]+\.[^@ \t\r\n]+/.freeze

  validates :email, uniqueness: true, presence: true, format: { with: EMAIL_REGEX, message: 'possui formato inválido' }
  validates :password, length: { minimum: 6 }, if: :password
end