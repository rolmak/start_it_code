require 'spec_helper'

feature "Levels" do
  let!(:admin)   { create :user, :admin }
  let!(:program) { create :program }
  let!(:level)   { create :level }
  let!(:program_level) { create :program_level, level: level, program: program }

  before do
    login_as(admin)
    visit admin_education_levels_path
  end

  it "Admin can see all level" do
    expect(page).to have_content level.name
  end

  it "Admin can create levels and add it to program" do
    click_link I18n.t('admin.education.levels.index.add_level')

    expect(page).to have_content I18n.t('admin.education.levels.new.new_level')
    expect(page).to have_content I18n.t('admin.education.levels.new.program_id')

    fill_in Education::Level.human_attribute_name(:name), with: "2. klase"
    fill_in Education::Level.human_attribute_name(:sequence), with: "2"
    check program.name

    click_button I18n.t('save')

    expect(page).to have_content I18n.t('admin.education.levels.create.notice')
    expect(Education::Level.last.name).to eq "2. klase"
    expect(Education::Level.last.sequence).to eq 2
    expect(Education::Level.last.program_levels.count).to eq 1
    expect(Education::Level.count).to eq 2
  end

  it "Admin can edit levels" do
    click_link I18n.t('edit')

    expect(page).to have_content I18n.t('admin.education.levels.edit.edit_level')
    expect(page).to have_content I18n.t('admin.education.levels.edit.program_id')

    fill_in Education::Level.human_attribute_name(:name), with: "3. klase"
    fill_in Education::Level.human_attribute_name(:sequence), with: "3"

    click_button I18n.t('save')

    expect(page).to have_content I18n.t('admin.education.levels.update.notice')
    expect(Education::Level.last.name).to eq "3. klase"
    expect(Education::Level.last.sequence).to eq 3
    expect(Education::Level.count).to eq 1
  end

  it "Admin can delete levels" do
    expect(page).to have_content level.name

    click_link I18n.t('destroy')

    expect(page).to have_content I18n.t('admin.education.levels.destroy.notice')
    expect(page).to_not have_content level.name
    expect(Education::Level.count).to eq 0
  end

  it "Admin can see level lesson list" do
    visit admin_education_program_path(program)

    click_link I18n.t('show')

    expect(page).to have_content program.name
    expect(page).to have_content level.name
  end

  it "Creating Level without filling name and sequence field will show error" do
    click_link I18n.t('admin.education.levels.index.add_level')

    expect(page).to have_content I18n.t('admin.education.levels.new.new_level')
    expect(page).to have_content I18n.t('admin.education.levels.new.program_id')

    click_button I18n.t('save')

    expect(page).to have_content I18n.t('error')
    expect(Education::Level.count).to eq 1
  end
end
