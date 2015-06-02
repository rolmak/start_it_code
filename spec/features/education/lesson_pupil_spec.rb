require 'spec_helper'

feature "Lessons for pupil" do
  let!(:user)          { create :user }
  let!(:level)         { create :level }
  let!(:program)       { create :program }
  let!(:program_level) { create :program_level, level: level, program: program }
  let!(:lesson)        { create :lesson, program_level: program_level }
  let!(:lesson_empty)  { create :lesson_empty, program_level: program_level}
  let!(:pattern)       { create :pattern, lesson: lesson }
  let!(:assignment)    { create :assignment, pattern: pattern }
  let!(:exercise)      { create :exercise, pattern: pattern }

  before do
    login_as(user)
  end

  it "User is logged in as pupil" do
    visit education_program_level_lesson_path(program_level, lesson)

    expect(page).to have_content "Skolēns"
  end

  it "Pupil can open lesson WITH assignments and exercises and see details" do
    visit education_program_level_lesson_path(program_level, lesson)

    expect(page).to have_content lesson.name
    expect(page).to have_content I18n.t('education.lessons.show.assignments')
    expect(page).to have_content assignment.name
    expect(page).to have_content assignment.description
    expect(page).to have_content I18n.t('education.lessons.show.exercises')
    expect(page).to have_content exercise.name
    expect(page).to have_content exercise.description
  end

  it "Pupil can open lesson WITHOUT assignments and exercises and see details" do
    visit education_program_level_lesson_path(program_level, lesson_empty)

    expect(page).to have_content lesson_empty.name
    expect(page).to_not have_content I18n.t('education.lessons.show.assignments')
    expect(page).to_not have_content assignment.name
    expect(page).to_not have_content assignment.description
    expect(page).to_not have_content I18n.t('education.lessons.show.exercises')
    expect(page).to_not have_content exercise.name
    expect(page).to_not have_content exercise.description
  end

  it "Pupil can send feedback" do
    visit education_program_level_lesson_path(program_level, lesson)

    fill_in Education::Feedback.human_attribute_name(:message), :with => 'Mājasdarbu neizdevās izpildīt'

    click_button I18n.t('send')

    expect(page).to have_content I18n.t('education.feedbacks.create.notice')
    expect(Education::Feedback.last.message).to eq "Mājasdarbu neizdevās izpildīt"
  end

  it "Pupil can send feedback WITH files", js: true do
    file_path = Rails.root.join('spec', 'fixtures', 'files', 'teksta_fails.docx')
    visit education_program_level_lesson_path(program_level, lesson)

    fill_in Education::Feedback.human_attribute_name(:message), :with => "Iesūtu izpildīto uzdevumu"

    click_link I18n.t('education.lessons.show.add_new_file')

    fill_in Education::Addition.human_attribute_name(:name), :with => "fails1"

    attach_file("addition_file", file_path)

    click_button I18n.t('send')

    expect(page).to have_content I18n.t('education.feedbacks.create.notice')
    expect(Education::Feedback.last.additions.first.name).to eq "fails1"
  end

  it "Pupil can't access feedback list" do
    visit education_program_level_lesson_pattern_feedbacks_path(program_level, lesson, pattern)

    expect(page).to have_content I18n.t('education.articles.index.articles')
  end
end
