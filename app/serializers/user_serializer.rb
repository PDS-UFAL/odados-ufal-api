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
class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :role, :sector
end
