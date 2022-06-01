# == Schema Information
#
# Table name: forms
#
#  id          :bigint           not null, primary key
#  description :string
#  sector_ids  :bigint           default([]), is an Array
#  title       :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class FormSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :created_at, :updated_at, :sections

  def sections
    object.sections&.map { |section| SectionSerializer.new(section, form_send_id: @instance_options[:form_send_id]) }
  end

  class SectorStatusSerializer < ActiveModel::Serializer
    attributes :id, :name, :status

    def status
      object.form_sectors&.find_by(form_id: @instance_options[:form].id).status
    end
  end
end
