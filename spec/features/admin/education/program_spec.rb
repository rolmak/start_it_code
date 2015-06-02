require 'spec_helper'

feature "Programs" do
  let!(:admin)   { create :user, :admin }
  let!(:program) { create :program }

  before do
    login_as(admin)
    visit admin_education_programs_path
  end

  it "Admin can see all programs" do
    expect(page).to have_content program.name
  end

  it "Admin can see what classes are in each program" do
    click_link I18n.t('show')

    expect(page).to have_content program.name
    expect(page).to have_content I18n.t('admin.education.programs.show.level_name')
  end

  it "Admin can create programs" do
    click_link I18n.t('admin.education.programs.index.add_program')

    expect(page).to have_content I18n.t('admin.education.programs.new.new_program')
    fill_in Education::Program.human_attribute_name(:name), with: "Informātika"

    click_button I18n.t('save')

    expect(page).to have_content I18n.t('admin.education.programs.create.notice')
    expect(Education::Program.last.name).to eq "Informātika"
  end

  it "Admin can edit programs" do
    click_link I18n.t('edit')

    expect(page).to have_content I18n.t('admin.education.programs.edit.edit_program')
    fill_in Education::Program.human_attribute_name(:name), with: "Informātika pamatskolā"

    click_button I18n.t('save')

    expect(page).to have_content I18n.t('admin.education.programs.update.notice')
    expect(Education::Program.last.name).to eq "Informātika pamatskolā"
  end

  it "Admin can delete programs" do
    expect(page).to have_content program.name

    click_link I18n.t('destroy')

    expect(page).to have_content I18n.t('admin.education.programs.destroy.notice')
    expect(page).to_not have_content program.name
    expect(Education::Program.count).to eq 0
  end

  it "Creating programs without filling name field will show error" do
    click_link I18n.t('admin.education.programs.index.add_program')

    expect(page).to have_content I18n.t('admin.education.programs.new.new_program')

    click_button I18n.t('save')

    expect(page).to have_content I18n.t('error')
    expect(Education::Program.count).to eq 1
  end
end
