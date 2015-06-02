require 'spec_helper'

feature "Lessons estimation list" do
  let!(:admin)         { create :user, :admin }
  let!(:level)         { create :level }
  let!(:program)       { create :program }
  let!(:program_level) { create :program_level, level: level, program: program }
  let!(:lesson)        { create :lesson, program_level: program_level }

  before do
    login_as(admin)
  end

  it "Admin can see all lesson estimations" do
    second_user = create(:second_user)
    estimation = create(:estimation, user: second_user)
    lesson.estimations << estimation

    visit admin_education_program_level_lesson_estimations_path(program_level, lesson)

    expect(page).to have_content I18n.t('admin.education.program_levels.show.estimations')
    expect(page).to have_content second_user.to_s
    expect(page).to have_content estimation.message
  end

  it "Admin can delete estimations" do
    second_user = create(:second_user)
    estimation = create(:estimation, user: second_user)
    lesson.estimations << estimation

    visit admin_education_program_level_lesson_estimations_path(program_level, lesson)

    expect(page).to have_content second_user.to_s
    expect(page).to have_content estimation.message

    click_link I18n.t('destroy')

    expect(page).to have_content I18n.t('admin.education.estimations.destroy.notice')
    expect(page).to_not have_content second_user.to_s
    expect(page).to_not have_content estimation.message
    expect(Education::Estimation.count).to eq 0
  end

  it "Admin sees message if estimation list is empty" do
    visit admin_education_program_level_lesson_estimations_path(program_level, lesson)

    expect(page).to have_content I18n.t('admin.education.program_levels.show.estimations')
    expect(page).to have_content I18n.t('admin.education.estimations.index.empty_estimation_list')
  end
end
