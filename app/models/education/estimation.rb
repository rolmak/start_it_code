class Education::Estimation < ActiveRecord::Base
  belongs_to :lesson, class_name: 'Education::Lesson'
  belongs_to :user

  validates :message, presence: :true
end

# == Schema Information
#
# Table name: education_estimations
#
#  created_at :datetime
#  id         :integer          not null, primary key
#  lesson_id  :integer
#  message    :text
#  updated_at :datetime
#  user_id    :integer
#
