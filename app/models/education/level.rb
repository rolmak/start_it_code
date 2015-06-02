class Education::Level < ActiveRecord::Base
  has_many :program_levels, class_name: 'Education::ProgramLevel'
  has_many :programs, class_name: 'Education::Program', through: :program_levels

  validates :name, :sequence, presence: true
end

# == Schema Information
#
# Table name: education_levels
#
#  created_at :datetime
#  id         :integer          not null, primary key
#  name       :string(255)
#  program_id :integer
#  sequence   :integer
#  updated_at :datetime
#
