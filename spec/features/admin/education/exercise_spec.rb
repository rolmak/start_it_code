require 'spec_helper'

feature "Exercises" do
  let!(:admin)         { create :user, :admin }
  let!(:level)         { create :level }
  let!(:program)       { create :program }
  let!(:program_level) { create :program_level, level: level, program: program }
  let!(:lesson)        { create :lesson, program_level: program_level }
  let!(:pattern)       { create :pattern, lesson: lesson }
  let!(:exercise)      { create :exercise, pattern: pattern }

  before do
    login_as(admin)
    visit admin_education_program_level_lesson_pattern_path(program_level, lesson, pattern)
  end

  it "Admin can create exercises for pattern" do
    click_link I18n.t('admin.education.patterns.show.add_exercise')

    expect(page).to have_content I18n.t('admin.education.exercises.new.new_exercise')

    fill_in Education::Exercise.human_attribute_name(:name), with: "2. vingrinājums"
    fill_in Education::Exercise.human_attribute_name(:sequence), with: "2"
    fill_in Education::Exercise.human_attribute_name(:description), with: "Atrast koka sakni"

    click_button I18n.t('save')

    expect(page).to have_content I18n.t('admin.education.exercises.create.notice')
    expect(Education::Exercise.last.name).to eq "2. vingrinājums"
    expect(Education::Exercise.last.sequence).to eq 2
    expect(Education::Exercise.last.description).to eq "Atrast koka sakni"
    expect(Education::Exercise.count).to eq 2
  end

  it "Admin can edit pattern exercises" do
    within '.exercise_selector' do
      click_link I18n.t('edit')
    end

    expect(page).to have_content I18n.t('admin.education.exercises.edit.edit_exercise')

    fill_in Education::Exercise.human_attribute_name(:name), with: "3. vingrinājums"
    fill_in Education::Exercise.human_attribute_name(:sequence), with: "3"
    fill_in Education::Exercise.human_attribute_name(:description), with: "Atrast koka sakni!"

    click_button I18n.t('save')

    expect(page).to have_content I18n.t('admin.education.exercises.update.notice')
    expect(Education::Exercise.last.name).to eq "3. vingrinājums"
    expect(Education::Exercise.last.sequence).to eq 3
    expect(Education::Exercise.last.description).to eq "Atrast koka sakni!"
    expect(Education::Exercise.count).to eq 1
  end

  it "Admin can delete pattern exercises" do
    expect(page).to have_content exercise.name
    expect(page).to have_content exercise.description

    within '.exercise_selector' do
      click_link I18n.t('destroy')
    end

    expect(page).to have_content I18n.t('admin.education.exercises.destroy.notice')
    expect(page).to_not have_content exercise.name
    expect(page).to_not have_content exercise.description
    expect(Education::Exercise.count).to eq 0
  end

  it "Creating exercises for pattern without filling name and sequence field will show error" do
    click_link I18n.t('admin.education.patterns.show.add_exercise')

    expect(page).to have_content I18n.t('admin.education.exercises.new.new_exercise')

    fill_in Education::Exercise.human_attribute_name(:description), with: "Atrast jaunā koka sakni"

    click_button I18n.t('save')

    expect(page).to have_content I18n.t('error')
    expect(Education::Exercise.count).to eq 1
  end
end
