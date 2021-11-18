class Sector < ApplicationRecord
  has_many :users

  EMAIL_REGEX = /[^@ \t\r\n]+@[^@ \t\r\n]+\.[^@ \t\r\n]+/.freeze

  validates :email, uniqueness: true, presence: true, format: { with: EMAIL_REGEX, message: 'possui formato inválido' }
  validates :name, presence: true
  validates :responsible, presence: true
end
