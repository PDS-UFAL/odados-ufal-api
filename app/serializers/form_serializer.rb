# == Schema Information
#
# Table name: forms
#
#  id          :bigint           not null, primary key
#  description :string
#  title       :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class FormSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :created_at, :updated_at, :sections

  def sectors
    object.sectors&.map { |sector| SectorStatusSerializer.new(sector, form: object) }
  end

  def sections
    object.sections&.map { |section| SectionSerializer.new(section) }
  end

  class SectorStatusSerializer < ActiveModel::Serializer
    attributes :id, :name, :status

    def status
      object.form_sectors&.find_by(form_id: @instance_options[:form].id).status
    end
  end
end
