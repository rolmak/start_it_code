require 'spec_helper'

feature "Teacher lessons" do
  let!(:teacher)       { create :user, :teacher }
  let!(:second_user)   { create :second_user }
  let!(:level)         { create :level }
  let!(:program)       { create :program }
  let!(:program_level) { create :program_level, level: level, program: program }
  let!(:lesson)        { create :lesson, program_level: program_level }
  let!(:lesson_empty)  { create :lesson_empty, program_level: program_level }
  let!(:pattern)       { create :pattern, lesson: lesson }
  let!(:classroom)     { create :classroom }
  let!(:feedback)      { create :feedback, user: second_user }
  let!(:addition)      { create :addition }

  before do
    login_as(teacher)
  end

  it "User is logged in as pupil" do
    visit education_program_level_lesson_path(program_level, lesson)

    expect(page).to have_content "Skolotājs"
  end

  it "Teacher can open lesson WITH steps and plan and see details" do
    visit education_program_level_lesson_path(program_level, lesson)

    expect(page).to have_content lesson.name
    expect(page).to have_content Education::Lesson.human_attribute_name(:step)
    expect(page).to have_content Education::Lesson.human_attribute_name(:plan)
  end

  it "Teacher can open lesson WITHOUT steps, plan and additions and see details" do
    visit education_program_level_lesson_path(program_level, lesson_empty)

    expect(page).to have_content lesson_empty.name
    expect(page).to_not have_content Education::Lesson.human_attribute_name(:step)
    expect(page).to_not have_content Education::Lesson.human_attribute_name(:plan)
    expect(page).to_not have_content Education::Lesson.human_attribute_name(:material)
  end

  it "Teacher can write estimations" do
    visit education_program_level_lesson_path(program_level, lesson)

    fill_in Education::Estimation.human_attribute_name(:message), :with => 'Labi sagatavota nodarbība'
    click_button I18n.t('send')
    expect(page).to have_content I18n.t('education.estimations.create.notice')
  end

  it "Teacher can see list of his pupil feedbacks" do
    pattern.feedbacks << feedback
    teacher.program_levels << program_level
    classroom.users << second_user
    teacher.teachable_classrooms << classroom
    visit education_program_level_lesson_path(program_level, lesson)

    click_link I18n.t('education.lessons.show.show_feedbacks')

    expect(page).to have_content I18n.t('education.feedbacks.all_feedbacks.feedbacks')
    expect(page).to have_content second_user.to_s
  end

  it "Teacher can see his pupil feedbacks WITHOUT additions" do
    pattern.feedbacks << feedback
    teacher.program_levels << program_level
    classroom.users << second_user
    teacher.teachable_classrooms << classroom

    visit education_program_level_lesson_pattern_feedbacks_path(program_level, lesson, pattern)

    click_link I18n.t('show')
    expect(page).to have_content I18n.t('education.feedbacks.show.user')
    expect(page).to have_content second_user.to_s
    expect(page).to have_content I18n.t('education.feedbacks.show.message')
    expect(page).to have_content feedback.message
  end

  it "Teacher can see his pupil feedbacks WITH additions" do
    feedback.additions << addition
    pattern.feedbacks << feedback
    teacher.program_levels << program_level
    classroom.users << second_user
    teacher.teachable_classrooms << classroom

    visit education_program_level_lesson_pattern_feedbacks_path(program_level, lesson, pattern)

    click_link I18n.t('show')
    expect(page).to have_content I18n.t('education.feedbacks.show.user')
    expect(page).to have_content second_user.to_s
    expect(page).to have_content I18n.t('education.feedbacks.show.message')
    expect(page).to have_content feedback.message
    expect(page).to have_content I18n.t('education.feedbacks.show.material')
    expect(page).to have_content feedback.additions.first.name
    expect(page).to have_content feedback.additions.first.file_url
  end
end
