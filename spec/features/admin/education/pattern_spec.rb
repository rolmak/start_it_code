require 'spec_helper'

feature "Patterns" do
  let!(:admin)         { create :user, :admin }
  let!(:level)         { create :level }
  let!(:program)       { create :program }
  let!(:program_level) { create :program_level, level: level, program: program }
  let!(:lesson)        { create :lesson, program_level: program_level }
  let!(:pattern)       { create :pattern, lesson: lesson }
  let!(:assignment)    { create :assignment, pattern: pattern }
  let!(:exercise)      { create :exercise, pattern: pattern }

  before do
    login_as(admin)
    visit admin_education_program_level_lesson_path(program_level, lesson)
  end

  it "Admin can see lesson patterns details" do
    click_link I18n.t('show')

    expect(page).to have_content pattern.name
    expect(page).to have_content assignment.name
    expect(page).to have_content assignment.description
    expect(page).to have_content exercise.name
    expect(page).to have_content exercise.description
  end

  it "Admin can create patterns for lesson" do
    click_link I18n.t('admin.education.lessons.show.add_pattern')

    expect(page).to have_content I18n.t('admin.education.patterns.new.new_pattern')

    fill_in Education::Pattern.human_attribute_name(:name), with: "2. Modulis"
    fill_in Education::Pattern.human_attribute_name(:sequence), with: "2"

    click_button I18n.t('save')

    expect(page).to have_content I18n.t('admin.education.patterns.create.notice')
    expect(Education::Pattern.last.name).to eq "2. Modulis"
    expect(Education::Pattern.last.sequence).to eq 2
    expect(Education::Pattern.count).to eq 2
  end

  it "Admin can create patterns for lesson with video" do
    click_link I18n.t('admin.education.lessons.show.add_pattern')

    expect(page).to have_content I18n.t('admin.education.patterns.new.new_pattern')

    fill_in Education::Pattern.human_attribute_name(:name), with: "2. Modulis"
    fill_in Education::Pattern.human_attribute_name(:sequence), with: "2"
    fill_in Education::Pattern.human_attribute_name(:video), with: "http://player.vimeo.com/video/74431217"

    click_button I18n.t('save')

    expect(page).to have_content I18n.t('admin.education.patterns.create.notice')
    expect(Education::Pattern.last.name).to eq "2. Modulis"
    expect(Education::Pattern.last.sequence).to eq 2
    expect(Education::Pattern.count).to eq 2
    expect(Education::Pattern.last.video).to eq "http://player.vimeo.com/video/74431217"
  end

  it "Admin can edit lesson patterns" do
    click_link I18n.t('edit')

    expect(page).to have_content I18n.t('admin.education.patterns.edit.edit_pattern')

    fill_in Education::Pattern.human_attribute_name(:name), with: "3. Modulis"
    fill_in Education::Pattern.human_attribute_name(:sequence), with: "3"

    click_button I18n.t('save')

    expect(page).to have_content I18n.t('admin.education.patterns.update.notice')
    expect(Education::Pattern.last.name).to eq "3. Modulis"
    expect(Education::Pattern.last.sequence).to eq 3
    expect(Education::Pattern.count).to eq 1
  end

  it "Admin can delete lesson patterns" do
    expect(page).to have_content pattern.name

    click_link I18n.t('destroy')

    expect(page).to have_content I18n.t('admin.education.patterns.destroy.notice')
    expect(page).to_not have_content pattern.name
    expect(Education::Pattern.count).to eq 0
  end

  it "Creating patterns for lesson without filling name and sequence field will show error" do
    click_link I18n.t('admin.education.lessons.show.add_pattern')

    expect(page).to have_content I18n.t('admin.education.patterns.new.new_pattern')

    fill_in Education::Pattern.human_attribute_name(:sequence), with: "4"

    click_button I18n.t('save')

    expect(page).to have_content I18n.t('error')
    expect(Education::Pattern.count).to eq 1
  end
end
