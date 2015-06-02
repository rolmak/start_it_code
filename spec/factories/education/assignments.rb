FactoryGirl.define do
  factory :assignment, class: Education::Assignment do
    add_attribute :sequence, "1"
    description "Atrast algoritma piemērus ikdienā"
    name "1. Uzdevums"
    pattern
  end
end
