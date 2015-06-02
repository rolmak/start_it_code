require 'spec_helper'

feature "Assignments" do
  let!(:admin)         { create :user, :admin }
  let!(:level)         { create :level }
  let!(:program)       { create :program }
  let!(:program_level) { create :program_level, level: level, program: program }
  let!(:lesson)        { create :lesson, program_level: program_level }
  let!(:pattern)       { create :pattern, lesson: lesson }
  let!(:assignment)    { create :assignment, pattern: pattern }

  before do
    login_as(admin)
    visit admin_education_program_level_lesson_pattern_path(program_level, lesson, pattern)
  end

  it "Admin can create assignments for pattern" do
    click_link I18n.t('admin.education.patterns.show.add_assignment')

    expect(page).to have_content I18n.t('admin.education.assignments.new.new_assignment')

    fill_in Education::Assignment.human_attribute_name(:name), with: "2. uzdevums"
    fill_in Education::Assignment.human_attribute_name(:sequence), with: "2"
    fill_in Education::Assignment.human_attribute_name(:description), with: "Atrast kokā vecāku ar visvairāk pēctečiem"

    click_button I18n.t('save')

    expect(page).to have_content I18n.t('admin.education.assignments.create.notice')
    expect(Education::Assignment.last.name).to eq "2. uzdevums"
    expect(Education::Assignment.last.sequence).to eq 2
    expect(Education::Assignment.last.description).to eq "Atrast kokā vecāku ar visvairāk pēctečiem"
  end

  it "Admin can edit pattern assignments" do
    within '.assignment_selector' do
      click_link I18n.t('edit')
    end

    expect(page).to have_content I18n.t('admin.education.assignments.edit.edit_assignment')

    fill_in Education::Assignment.human_attribute_name(:name), with: "3. uzdevums"
    fill_in Education::Assignment.human_attribute_name(:sequence), with: "3"
    fill_in Education::Assignment.human_attribute_name(:description), with: "Atrast kokā vecāku ar visvairāk pēctečiem!"

    click_button I18n.t('save')

    expect(page).to have_content I18n.t('admin.education.assignments.update.notice')
    expect(Education::Assignment.last.name).to eq "3. uzdevums"
    expect(Education::Assignment.last.sequence).to eq 3
    expect(Education::Assignment.last.description).to eq "Atrast kokā vecāku ar visvairāk pēctečiem!"
  end

  it "Admin can delete pattern assignments" do
    expect(page).to have_content assignment.name
    expect(page).to have_content assignment.description

    within '.assignment_selector' do
      click_link I18n.t('destroy')
    end

    expect(page).to have_content I18n.t('admin.education.assignments.destroy.notice')
    expect(page).to_not have_content assignment.name
    expect(page).to_not have_content assignment.description
    expect(Education::Assignment.count).to eq 0
  end

  it "Creating assignments for pattern without filling name and sequence fields will show error" do
    click_link I18n.t('admin.education.patterns.show.add_assignment')

    expect(page).to have_content I18n.t('admin.education.assignments.new.new_assignment')

    fill_in Education::Assignment.human_attribute_name(:description), with: "Atrast otra koka vecāku ar visvairāk pēctečiem"

    click_button I18n.t('save')

    expect(page).to have_content I18n.t('error')
    expect(Education::Assignment.count).to eq 1
  end
end
