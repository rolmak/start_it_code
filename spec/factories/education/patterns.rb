FactoryGirl.define do
  factory :pattern, class: Education::Pattern do
    add_attribute :sequence, "1"
    name "1. Modulis"
    video "http://player.vimeo.com/video/73912320"
    lesson
  end
end
