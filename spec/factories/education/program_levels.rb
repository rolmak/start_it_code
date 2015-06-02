FactoryGirl.define do
  factory :program_level, class: Education::ProgramLevel do
    level
    program
  end
end
