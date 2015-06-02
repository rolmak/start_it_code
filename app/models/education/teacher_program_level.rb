class Education::TeacherProgramLevel < ActiveRecord::Base
  belongs_to :user, class_name: 'Education::User'
  belongs_to :program_level, class_name: 'Education::ProgramLevel'
end

# == Schema Information
#
# Table name: education_teacher_program_levels
#
#  created_at       :datetime
#  id               :integer          not null, primary key
#  program_level_id :integer
#  updated_at       :datetime
#  user_id          :integer
#
