# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  active                 :boolean          default(TRUE), not null
#  email                  :string           not null
#  name                   :string
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
require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
