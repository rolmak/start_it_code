class Education::Article < ActiveRecord::Base
  before_save :set_articles_publishing_time

  validates :title, :description, presence: true

  scope :published, -> { where(published: true) }
  scope :top_story, -> { where(top_story: true) }

  def set_articles_publishing_time
    self.published_at = self.published? ? Time.now : nil
  end
end

# == Schema Information
#
# Table name: education_articles
#
#  created_at   :datetime
#  description  :text
#  id           :integer          not null, primary key
#  published    :boolean          default(FALSE)
#  published_at :datetime
#  title        :string(255)
#  top_story    :boolean          default(FALSE)
#  updated_at   :datetime
#
