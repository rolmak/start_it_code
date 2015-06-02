class Education::ProgramLevel < ActiveRecord::Base
  belongs_to :program, class_name: 'Education::Program'
  belongs_to :level, class_name: 'Education::Level'
  has_many :lessons, class_name: 'Education::Lesson'
  has_many :teacher_program_levels, class_name: 'Education::TeacherProgramLevel'
  has_many :users, through: :teacher_program_levels

  def name
    "#{program.name} - #{level.name}"
  end
end

# == Schema Information
#
# Table name: education_program_levels
#
#  created_at :datetime
#  id         :integer          not null, primary key
#  level_id   :integer
#  program_id :integer
#  updated_at :datetime
#
