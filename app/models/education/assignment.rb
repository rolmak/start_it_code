class Education::Assignment < ActiveRecord::Base
  belongs_to :pattern, class_name: 'Education::Pattern'

  validates :name, :sequence, presence: true
end

# == Schema Information
#
# Table name: education_assignments
#
#  created_at  :datetime
#  description :text
#  id          :integer          not null, primary key
#  name        :string(255)
#  pattern_id  :integer
#  sequence    :integer
#  updated_at  :datetime
#
