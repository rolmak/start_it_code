class Education::Feedback < ActiveRecord::Base
  belongs_to :user
  belongs_to :pattern, class_name: 'Education::Pattern'
  has_many :additions, class_name: 'Education::Addition'

  accepts_nested_attributes_for :additions, :reject_if => :all_blank, :allow_destroy => true

  def self.for_users(users_scope)
    where(user_id: users_scope.pluck(:id))
  end
end

# == Schema Information
#
# Table name: education_feedbacks
#
#  created_at :datetime
#  id         :integer          not null, primary key
#  message    :text
#  pattern_id :integer
#  updated_at :datetime
#  user_id    :integer
#
