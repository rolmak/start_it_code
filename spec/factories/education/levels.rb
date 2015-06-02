FactoryGirl.define do
  factory :level, class: Education::Level do
    add_attribute :sequence, "1"
    name "1. Klase"
  end
end
