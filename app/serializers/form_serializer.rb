# == Schema Information
#
# Table name: forms
#
#  id         :bigint           not null, primary key
#  end_date   :datetime         not null
#  start_date :datetime         not null
#  status     :integer          default("open"), not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class FormSerializer < ActiveModel::Serializer
  attributes :id, :title, :start_date, :end_date, :status, :created_at, :updated_at, :sectors, :sections

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
