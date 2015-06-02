FactoryGirl.define do
  factory :classroom do
    name "2.b"
  end
end

# == Schema Information
#
# Table name: classrooms
#
#  created_at :datetime
#  id         :integer          not null, primary key
#  name       :string(255)
#  teacher_id :integer
#  updated_at :datetime
#
