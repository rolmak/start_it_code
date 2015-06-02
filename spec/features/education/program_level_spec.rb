require 'spec_helper'

feature "Program Level" do
  let!(:user)          { create :user }
  let!(:level)         { create :level }
  let!(:program)       { create :program }
  let!(:program_level) { create :program_level, level: level, program: program }
  let!(:lesson)        { create :lesson, program_level: program_level }

  it "User can see lesson list in education/program_levels" do
    login_as(user)

    visit education_program_level_path(program_level)

    expect(page).to have_content lesson.name
  end

  it "User can sign out" do
    login_as(user)

    visit education_program_level_path(program_level)

    click_link I18n.t('exit')

    expect(page).to have_content 'Pieslēgties'
  end

  it "User must be signed in to visit /education" do
    visit education_path

    expect(page).to have_content I18n.t('devise.failure.unauthenticated')
  end
end
