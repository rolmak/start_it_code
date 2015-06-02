class Education::Lesson < ActiveRecord::Base
  belongs_to :program_level, class_name: 'Education::ProgramLevel'
  has_many :patterns, class_name: 'Education::Pattern'
  has_many :estimations, class_name: 'Education::Estimation'

  validates :name, :code, :sequence, presence: true

  def next_lesson
    program_level.lessons.where('sequence >= ?', sequence).where.not(id: id).order(:sequence).first
  end

  def prev_lesson
    program_level.lessons.where('sequence <= ?', sequence).where.not(id: id).order(:sequence).last
  end
end

# == Schema Information
#
# Table name: education_lessons
#
#  code             :string(255)
#  created_at       :datetime
#  id               :integer          not null, primary key
#  name             :string(255)
#  plan             :text
#  program_level_id :integer
#  pupil_material   :text
#  sequence         :integer
#  step             :text
#  teacher_material :text
#  updated_at       :datetime
#
