# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           not null
#  password_digest        :string           not null
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :integer          default("employee"), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  sector_id              :bigint
#
# Indexes
#
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_sector_id             (sector_id)
#
# Foreign Keys
#
#  fk_rails_...  (sector_id => sectors.id)
#
class User < ApplicationRecord
  has_secure_password

  belongs_to :sector, optional: true
  has_many :responses

  enum role: {
    admin: 0,
    employee: 1
  }

  EMAIL_REGEX = /[^@ \t\r\n]+@[^@ \t\r\n]+\.[^@ \t\r\n]+/.freeze

  validates :email, uniqueness: true, presence: true, format: { with: EMAIL_REGEX, message: 'invalid format' }
  validates :password_digest, presence: true
  validates :password, length: { minimum: 6 }, if: :password
  validates :password_confirmation, presence: true, if: :password
  validates :role, presence: true
  validates :sector_id, presence: true, if: :employee?

  scope :sector_id, ->(sector_id) { where(sector_id: sector_id) }
  scope :role, ->(role) { where(role: role) }
  
  def send_form_notification form
    UserMailer.with(user: self, form: form).form_creation.deliver_now
  end

  def send_response_notification form, sector
    UserMailer.with(user: self, form: form, sector: sector).form_response.deliver_now
  end
end
