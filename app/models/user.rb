# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string
#  password_digest :string
#  role            :integer          default("employee"), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  sector_id       :bigint
#
# Indexes
#
#  index_users_on_sector_id  (sector_id)
#
# Foreign Keys
#
#  fk_rails_...  (sector_id => sectors.id)
#
class User < ApplicationRecord
  has_secure_password

  belongs_to :sector, optional: true

  enum role: {
    admin: 0,
    employee: 1
  }

  EMAIL_REGEX = /[^@ \t\r\n]+@[^@ \t\r\n]+\.[^@ \t\r\n]+/.freeze

  validates :email, uniqueness: true, presence: true, format: { with: EMAIL_REGEX, message: 'possui formato inválido' }
  validates :password, length: { minimum: 6 }, if: :password
  validates :role, presence: true

  scope :sector_id, ->(sector_id) { where(sector_id: sector_id) }
  scope :role, ->(role) { where(role: role) }
end
