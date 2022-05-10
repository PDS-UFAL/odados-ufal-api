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
require "test_helper"

class SectorTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
