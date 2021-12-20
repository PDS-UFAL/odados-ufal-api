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
require 'rails_helper'

RSpec.describe Form, type: :model, timecop: true do
  describe 'associations' do
    it { should have_many(:sections) }
    it { should have_many(:form_sectors) }
    it { should have_many(:sectors).through(:form_sectors) }
    it { should accept_nested_attributes_for(:sections) }
  end

  describe 'enums' do
    it { should define_enum_for(:status).with_values(closed: 0, open: 1) }
  end

  describe 'validations' do
    [:title, :status, :start_date, :end_date].each { |attribute| it { should validate_presence_of(attribute) } }

    it { should_not allow_value(Time.current.midnight - 1.second).for(:start_date) }
    it { should_not allow_value(Time.current.midnight).for(:end_date) }
  end
end
