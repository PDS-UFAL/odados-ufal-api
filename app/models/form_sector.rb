# == Schema Information
#
# Table name: form_sectors
#
#  id         :bigint           not null, primary key
#  status     :integer          default("waiting_response"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  form_id    :bigint           not null
#  sector_id  :bigint           not null
#
# Indexes
#
#  index_form_sectors_on_form_id    (form_id)
#  index_form_sectors_on_sector_id  (sector_id)
#
# Foreign Keys
#
#  fk_rails_...  (form_id => forms.id)
#  fk_rails_...  (sector_id => sectors.id)
#
class FormSector < ApplicationRecord
  include FormSector::Stateable

  belongs_to :form
  belongs_to :sector

  enum status: {
    waiting_response: 0,
    answered: 1,
    waiting_resend: 2,
    closed: 3
  }

  after_create :notify_users

  private

  def notify_users
    FormCreationNotifyUsersWorker.perform_async(sector, form)
  end

  def notify_admins
    FormResponseNotifyAdminsWorker.perform_async(sector, form)
  end
end
