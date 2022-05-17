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
require 'rails_helper'

RSpec.describe Form, type: :model, timecop: true do
  describe 'associations' do
    it { should have_many(:sections) }
    it { should have_many(:form_sectors) }
    it { should have_many(:sectors).through(:form_sectors) }
    it { should accept_nested_attributes_for(:sections) }
  end

  describe 'enums' do
    it { should define_enum_for(:status).with_values(closed: 0, open: 1, not_started: 2) }
  end

  describe 'validations' do
    [:title, :status, :start_date, :end_date].each { |attribute| it { should validate_presence_of(attribute) } }

    it { should_not allow_value(Time.current.midnight - 1.second).for(:start_date) }
    it { should_not allow_value(Time.current.midnight).for(:end_date) }
  end

  describe 'scopes' do
    let!(:forms) { create_list(:form, 10) }
    let(:form) { forms.first }

    context ':title' do
      it 'filters the forms by title, returns a json with only the forms with the given title' do
        expect(Form.title(form.title)).to all( have_attributes(title: form.title) )
      end
    end

    context ':status' do
      it 'filters the forms by status, returns a json with only the forms with the given status' do
        expect(Form.status(:open)).to all( have_attributes(status: 'open') )
        expect(Form.status(:closed)).to all( have_attributes(status: 'closed') )
      end
    end

    context ':start_date' do
      it 'filters the forms by start_date, returns a json with only the forms with the given start_date' do
        expect(Form.start_date(form.start_date)).to all( satisfy { |f| f.start_date >= Time.current.midnight } )
      end
    end

    context ':end_date' do
      it 'filters the forms by end_date, returns a json with only the forms with the given end_date' do
        expect(Form.start_date(form.end_date)).to all( satisfy { |f| f.end_date >= Time.current.end_of_day } )
      end
    end
  end
end
