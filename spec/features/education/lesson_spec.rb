require 'spec_helper'

feature "Lessons for all users" do
  let!(:user)          { create :user }
  let!(:program)       { create :program }
  let!(:level)         { create :level }
  let!(:program_level) { create :program_level, level: level, program: program }
  let!(:lesson)        { create :lesson, program_level: program_level }
  let!(:lesson_empty)  { create :lesson_empty, program_level: program_level}

  before do
    login_as(user)
  end

  it "Successfully go to next lesson" do
    visit education_program_level_lesson_path(program_level, lesson)
    find(:css, "#navigate_next_lesson").click
    expect(page).to have_content lesson_empty.name
  end

  it "Successfully go to previous lesson" do
    visit education_program_level_lesson_path(program_level, lesson_empty)
    find(:css, "#navigate_previous_lesson").click
    expect(page).to have_content lesson.name
  end
end
