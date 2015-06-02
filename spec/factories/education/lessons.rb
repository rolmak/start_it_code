FactoryGirl.define do
  factory :lesson, class: Education::Lesson do
    add_attribute :sequence, "1"
    name "1. Nodarbība"
    code "1.01"
    plan "Iepazīt algoritmus"
    step "1. Ievads  2. Secinājumi"
    teacher_material "fails_skolotājiem.docx"
    pupil_material "fails_skolēniem.pptx"
    program_level
  end

  factory :lesson_empty, class: Education::Lesson do
    add_attribute :sequence, "2"
    name "2. Nodarbība"
    code "1.02"
    program_level
  end
end
