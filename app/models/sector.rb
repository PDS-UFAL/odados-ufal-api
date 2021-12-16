# == Schema Information
#
# Table name: sectors
#
#  id          :bigint           not null, primary key
#  email       :string
#  name        :string
#  responsible :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Sector < ApplicationRecord
  has_many :form_sectors
  has_many :forms, through: :form_sectors
  has_many :users

  EMAIL_REGEX = /[^@ \t\r\n]+@[^@ \t\r\n]+\.[^@ \t\r\n]+/.freeze

  validates :email, uniqueness: true, presence: true, format: { with: EMAIL_REGEX, message: 'possui formato inválido' }
  validates :name, presence: true
  validates :responsible, presence: true
end
