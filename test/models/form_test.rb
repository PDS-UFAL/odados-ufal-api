# == Schema Information
#
# Table name: forms
#
#  id           :bigint           not null, primary key
#  end_date     :date
#  initial_date :date
#  sections     :jsonb            not null
#  title        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
require "test_helper"

class FormTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
