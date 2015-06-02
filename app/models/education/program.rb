class Education::Program < ActiveRecord::Base
  has_many :program_levels, class_name: 'Education::ProgramLevel'
  has_many :levels, class_name: 'Education::Level', through: :program_levels

  validates :name, presence: true

  def sorted_levels
    levels.order(:sequence)
  end
end

# == Schema Information
#
# Table name: education_programs
#
#  created_at :datetime
#  id         :integer          not null, primary key
#  name       :string(255)
#  updated_at :datetime
#
