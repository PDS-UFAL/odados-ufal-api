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
class SectorSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :responsible
end
