require 'spec_helper'

feature "Lessons" do
  let!(:admin)         { create :user, :admin, :teacher }
  let!(:second_user)   { create :second_user }
  let!(:level)         { create :level }
  let!(:program)       { create :program }
  let!(:program_level) { create :program_level, level: level, program: program }
  let!(:lesson)        { create :lesson, program_level: program_level }
  let!(:pattern)       { create :pattern, lesson: lesson }
  let!(:assignment)    { create :assignment, pattern: pattern }
  let!(:exercise)      { create :exercise, pattern: pattern }
  let!(:estimation)    { create :estimation, user: second_user, lesson: lesson }

  before do
    login_as(admin)
    visit admin_education_program_level_path(program_level)
  end

  it "Admin can see lessons details" do
    visit admin_education_program_level_lesson_path(program_level, lesson)

    expect(page).to have_content lesson.name
    expect(page).to have_content lesson.sequence
    expect(page).to have_content lesson.plan
    expect(page).to have_content lesson.step
    expect(page).to have_content I18n.t('admin.education.lessons.show.patterns')
  end

  it "Admin can see all level lessons" do
    expect(page).to have_content program.name
    expect(page).to have_content level.name
    expect(page).to have_content program.name
    expect(page).to have_content level.name
    expect(page).to have_content I18n.t('admin.education.program_levels.show.lesson_name')
    expect(page).to have_content lesson.name
  end

  it "Admin can see lessons estimations" do
    lesson.estimations << estimation

    click_link I18n.t('admin.education.program_levels.show.estimations')

    expect(page).to have_content level.name
    expect(page).to have_content lesson.name
    expect(page).to have_content second_user.to_s
    expect(page).to have_content estimation.message
  end

  it "Admin can see lessons estimations" do
    lesson.estimations << estimation

    click_link I18n.t('admin.education.program_levels.show.estimations')

    expect(page).to have_content level.name
    expect(page).to have_content lesson.name
    expect(page).to have_content second_user.to_s
    expect(page).to have_content estimation.message
  end

  it "Admin can create lessons" do
    click_link I18n.t('admin.education.program_levels.show.add_lesson')

    expect(page).to have_content I18n.t('admin.education.lessons.new.new_lesson')

    fill_in Education::Lesson.human_attribute_name(:name), with: "2. nodarbība"
    fill_in Education::Lesson.human_attribute_name(:sequence), with: "2"
    fill_in Education::Lesson.human_attribute_name(:code), with: "1.02"
    fill_in Education::Lesson.human_attribute_name(:plan), with: "Iemācīt pamata algoritmus"
    fill_in Education::Lesson.human_attribute_name(:step), with: "1. izpildīt vingrinājumus 2. iedot mājasdarba uzdevumus"

    click_button I18n.t('save')
    expect(page).to have_content I18n.t('admin.education.lessons.create.notice')
    expect(Education::Lesson.last.name).to eq "2. nodarbība"
    expect(Education::Lesson.last.sequence).to eq 2
    expect(Education::Lesson.last.code).to eq "1.02"
    expect(Education::Lesson.last.plan).to eq "Iemācīt pamata algoritmus"
    expect(Education::Lesson.last.step).to eq "1. izpildīt vingrinājumus 2. iedot mājasdarba uzdevumus"
  end

  it "Admin can edit lessons" do
    click_link I18n.t('edit')

    expect(page).to have_content I18n.t('admin.education.lessons.edit.edit_lesson')

    fill_in Education::Lesson.human_attribute_name(:name), with: "3. nodarbība"
    fill_in Education::Lesson.human_attribute_name(:sequence), with: "3"
    fill_in Education::Lesson.human_attribute_name(:code), with: "1.03"
    fill_in Education::Lesson.human_attribute_name(:plan), with: "Iemācīt pamata algoritmus"
    fill_in Education::Lesson.human_attribute_name(:step), with: "1. izpildīt pirmos vingrinājumus 2. iesākt uzdeuvmus"

    click_button I18n.t('save')

    expect(page).to have_content I18n.t('admin.education.lessons.update.notice')
    expect(Education::Lesson.first.name).to eq "3. nodarbība"
    expect(Education::Lesson.first.sequence).to eq 3
    expect(Education::Lesson.last.code).to eq "1.03"
    expect(Education::Lesson.first.plan).to eq "Iemācīt pamata algoritmus"
    expect(Education::Lesson.first.step).to eq "1. izpildīt pirmos vingrinājumus 2. iesākt uzdeuvmus"

  end

  it "Admin can see lessons preview" do
    click_link I18n.t('admin.education.program_levels.show.preview')

    expect(page).to have_content lesson.name
    expect(page).to have_content lesson.plan
    expect(page).to have_content lesson.step
  end

  it "Admin can see lessons details" do
    click_link I18n.t('show')
    expect(page).to have_content lesson.name
  end

  it "Admin can delete lessons" do
    expect(page).to have_content lesson.name

    click_link I18n.t('destroy')

    expect(page).to have_content I18n.t('admin.education.lessons.destroy.notice')
    expect(page).to_not have_content lesson.name
    expect(Education::Lesson.count).to eq 0
  end

  it "Creating lesson without filling name and sequence field will show error" do
    click_link I18n.t('admin.education.program_levels.show.add_lesson')

    expect(page).to have_content I18n.t('admin.education.lessons.new.new_lesson')

    fill_in Education::Lesson.human_attribute_name(:plan), with: "Iemācīt jaunu algoritmu"
    fill_in Education::Lesson.human_attribute_name(:step), with: "1. aprēķini"

    click_button I18n.t('save')

    expect(page).to have_content I18n.t('error')
    expect(Education::Lesson.count).to eq 1
  end
end
