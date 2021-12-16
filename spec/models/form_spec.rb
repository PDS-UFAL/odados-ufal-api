# == Schema Information
#
# Table name: forms
#
#  id         :bigint           not null, primary key
#  end_date   :date
#  start_date :date
#  status     :integer          default("open"), not null
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Forms, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
