# == Schema Information
#
# Table name: sectors
#
#  id           :bigint           not null, primary key
#  abbreviation :string
#  email        :string           not null
#  name         :string           not null
#  responsible  :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class SectorSerializer < ActiveModel::Serializer
  attributes :id, :name, :abbreviation, :email, :responsible
  attribute :users , if: :condition?

  def condition?
    @instance_options[:users_flag].present? and @instance_options[:users_flag]
  end

  def users
    @users = User.where(sector_id: object.id, active: true)
    @users.map { |user| UserSerializer.new(user) }
  end

end
