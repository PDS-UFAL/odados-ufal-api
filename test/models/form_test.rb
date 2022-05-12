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
require "test_helper"

class FormTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
