require 'spec_helper'

feature "Teacher classes" do
  let!(:teacher)       { create :second_user, :teacher }
  let!(:admin)         { create :user, :admin }
  let!(:program)       { create :program }
  let!(:level)         { create :level }
  let!(:program_level) { create :program_level, level: level, program: program }

  before do
    login_as(admin)
    visit admin_education_teachers_path
  end

  it "Admin can see all teachers" do
    expect(page).to have_content I18n.t('admin.education.teachers.index.teachers')
    expect(page).to have_content teacher.first_name
    expect(page).to have_content teacher.last_name
  end

  it "Admin can add classes to teachers" do
    click_link I18n.t('add')

    expect(page).to have_content I18n.t('admin.education.teachers.edit.add_level')
    expect(page).to have_content I18n.t('admin.education.teachers.edit.program_level_id')
    check "#{program.name} - #{level.name}"

    click_button I18n.t('save')

    expect(page).to have_content I18n.t('admin.education.teachers.update.notice')
    expect(teacher.program_levels.count).to eq 1
  end
end
