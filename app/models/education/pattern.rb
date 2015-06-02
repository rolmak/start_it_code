class Education::Pattern < ActiveRecord::Base
  belongs_to :lesson, class_name: 'Education::Lesson'
  has_many   :video_attachments, class_name: 'Education::VideoAttachment'
  has_many   :exercises, class_name: 'Education::Exercise'
  has_many   :assignments, class_name: 'Education::Assignment'
  has_many   :feedbacks, class_name: 'Education::Feedback'

  validates :name, :sequence, presence: true

  accepts_nested_attributes_for :feedbacks, reject_if: :all_blank, allow_destroy: true

  def sorted_assignments
    assignments.order(:sequence)
  end
  
  def sorted_exercises
    exercises.order(:sequence)
  end
end

# == Schema Information
#
# Table name: education_patterns
#
#  created_at :datetime
#  id         :integer          not null, primary key
#  lesson_id  :integer
#  name       :string(255)
#  sequence   :integer
#  updated_at :datetime
#  video      :string(255)
#
