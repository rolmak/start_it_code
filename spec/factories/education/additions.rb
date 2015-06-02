FactoryGirl.define do
  factory :addition, class: Education::Addition do
    name "Izpildītā_uzdevuma_fails"
    file "teskta_fails.docx"
    feedback
  end
end
