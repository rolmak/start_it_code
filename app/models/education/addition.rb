class Education::Addition < ActiveRecord::Base
  belongs_to :feedback, class_name: 'Education::Feedback'

  validates :name, presence: :true

  mount_uploader :file, FileUploader
end

# == Schema Information
#
# Table name: education_additions
#
#  created_at  :datetime
#  feedback_id :integer
#  file        :string(255)
#  id          :integer          not null, primary key
#  name        :string(255)
#  updated_at  :datetime
#
