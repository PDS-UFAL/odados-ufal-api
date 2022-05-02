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
require 'rails_helper'

RSpec.describe Sector, type: :model do
  describe 'associations' do
    it { should have_many(:users) }
    it { should have_many(:form_sectors) }
    it { should have_many(:forms).through(:form_sectors) }
  end

  describe 'validations' do
    subject { create(:sector) }
    
    it { should validate_uniqueness_of(:email) }
    it { should_not allow_value('test@test').for(:email) }

    [:email, :name].each { |attribute| it { should validate_presence_of(attribute) } }
  end
end
