FactoryGirl.define do
  factory :exercise, class: Education::Exercise do
    add_attribute :sequence, "1"
    description "Atrast nepieciešamo rezultātu izmantojot doto algoritmu"
    name "1. Vingrinājums"
    pattern
  end
end
