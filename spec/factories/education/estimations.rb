FactoryGirl.define do
  factory :estimation, class: Education::Estimation do
    message "Veiksmīgi sagatavota stunda"
    user
    lesson
  end
end
