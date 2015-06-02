FactoryGirl.define do
  factory :article, class: Education::Article do
    published true
    published_at "2011-11-11 11:11:11"
    description "Algoritmu pielietojums ikdienā"
    title "Algoritmi"
  end
end
