require 'spec_helper'

feature "Admin menu" do
  let!(:admin)   { create :user, :admin }
  let!(:program) { create :program }

  before do
    login_as(admin)
  end

  it "Admin can see education menu > Programs" do
    visit admin_path
    expect(page).to have_content I18n.t('layouts.admin.education')
    page.find(:xpath, "//a[@href='/admin/education/programs']").click
    expect(page).to have_content I18n.t('layouts.admin.programs')
  end

  it "Admin can see education menu > Levels" do
    visit admin_path
    expect(page).to have_content I18n.t('layouts.admin.education')
    page.find(:xpath, "//a[@href='/admin/education/levels']").click
    expect(page).to have_content I18n.t('layouts.admin.levels')
  end

  it "Admin can see education menu > Teachers" do
    visit admin_path
    expect(page).to have_content I18n.t('layouts.admin.education')
    page.find(:xpath, "//a[@href='/admin/education/teachers']").click
    expect(page).to have_content I18n.t('layouts.admin.teachers')
  end

  it "Admin can see education article menu > Articles" do
    visit admin_path
    expect(page).to have_content I18n.t('layouts.admin.education')
    page.find(:xpath, "//a[@href='/admin/education/articles']").click
    expect(page).to have_content I18n.t('layouts.admin.articles')
  end
end
