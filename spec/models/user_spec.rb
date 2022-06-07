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
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_secure_password }
    it { should belong_to(:sector).optional }
    it { should have_many(:responses) }
  end

  describe 'validations' do
    subject { create(:user, :with_sector, sector_id: create(:sector).id ) }

    it { should validate_uniqueness_of(:email) }
    it { should validate_length_of(:password).is_at_least(6) }
    
    [:email, :password_digest, :role].each { |attribute| it { should validate_presence_of(attribute) } }

    context 'admin' do
      before { allow(subject).to receive(:employee?).and_return(false) }

      it { should_not validate_presence_of(:sector_id) }
    end

    context 'employee' do
      before { allow(subject).to receive(:employee?).and_return(true) }

      it { should validate_presence_of(:sector_id) }
    end
  end

  describe 'enums' do
    it { should define_enum_for(:role).with_values(admin: 0, employee: 1) }
  end

  describe 'scopes' do
    let!(:sector) { create(:sector) }
    let!(:user) { create(:user, :with_sector, sector_id: sector.id) }

    context ':sector_id' do
      it 'filters the users by sector_id, returns a json with only the users with the given sector_id' do              
        expect(User.sector_id(1)).to all( have_attributes(sector_id: 1) )
      end
    end

    context ':role' do
      it 'filters the users by role, returns a json with only the users with the given role' do      
        expect(User.role(1)).to all( have_attributes(role: 'employee') )
      end
    end
  end
end
