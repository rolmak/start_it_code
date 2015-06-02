require 'spec_helper'

feature "Articles" do
  let!(:admin)   { create :user, :admin }
  let!(:article) { create :article }

  before do
    login_as(admin)
    visit admin_education_articles_path
  end

  it "Admin can see all articles" do
    expect(page).to have_content I18n.t('admin.education.articles.index.page_title')
    expect(page).to have_content I18n.t('admin.education.articles.index.add_article')
    expect(page).to have_content article.title
    expect(page).to have_content article.description
  end

  it "Admin can create articles" do
    click_link I18n.t('admin.education.articles.index.add_article')

    expect(page).to have_content I18n.t('admin.education.articles.new.new_article')

    fill_in Education::Article.human_attribute_name(:title), with: "Pirmais jaunums"
    fill_in Education::Article.human_attribute_name(:description), with: "Jaunuma apraksts"
    click_button I18n.t('save')

    expect(page).to have_content I18n.t('admin.education.articles.create.notice')
    expect(Education::Article.last.title).to eq "Pirmais jaunums"
    expect(Education::Article.last.description). to eq "Jaunuma apraksts"
    expect(Education::Article.count).to eq 2
  end

  it "Admin can edit all articles" do
    click_link(I18n.t('edit'))

    expect(page).to have_content I18n.t('admin.education.articles.edit.edit_article')

    fill_in Education::Article.human_attribute_name(:title), with: "Otrais jaunums"
    fill_in Education::Article.human_attribute_name(:description), with: "Šeit ir apraksts par otro jaunumu!"
    click_button I18n.t('save')

    expect(page).to have_content I18n.t('.admin.education.articles.update.notice')
    expect(Education::Article.last.title).to eq "Otrais jaunums"
    expect(Education::Article.last.description).to eq "Šeit ir apraksts par otro jaunumu!"
    expect(Education::Article.count).to eq 1
  end

  it "Admin can delete all articles" do
    expect(page).to have_content article.title
    expect(page).to have_content article.description

    click_link I18n.t('destroy')

    expect(page).to have_content I18n.t('admin.education.articles.destroy.notice')
    expect(page).to_not have_content article.title
    expect(page).to_not have_content article.description
    expect(Education::Article.count).to eq 0
  end

  it "Admin can create articles and set if it is published and top story" do
    click_link I18n.t('admin.education.articles.index.add_article')

    expect(page).to have_content I18n.t('admin.education.articles.new.new_article')

    fill_in Education::Article.human_attribute_name(:title), with: "Pirmais jaunums"
    fill_in Education::Article.human_attribute_name(:description), with: "Jaunuma apraksts"
    check Education::Article.human_attribute_name(:published)
    check Education::Article.human_attribute_name(:top_story)

    click_button I18n.t('save')

    expect(page).to have_content I18n.t('admin.education.articles.create.notice')
    expect(Education::Article.last.title).to eq "Pirmais jaunums"
    expect(Education::Article.last.description).to eq "Jaunuma apraksts"
    expect(Education::Article.last.published).to eq true
    expect(Education::Article.last.top_story).to eq true
    expect(Education::Article.count).to eq 2
  end

  it "Admin can create articles and set if it is published" do
    click_link I18n.t('admin.education.articles.index.add_article')

    expect(page).to have_content I18n.t('admin.education.articles.new.new_article')

    fill_in Education::Article.human_attribute_name(:title), with: "Otrais jaunums"
    fill_in Education::Article.human_attribute_name(:description), with: "Jaunuma garais apraksts"
    check Education::Article.human_attribute_name(:published)

    click_button I18n.t('save')

    expect(page).to have_content I18n.t('admin.education.articles.create.notice')
    expect(Education::Article.last.title).to eq "Otrais jaunums"
    expect(Education::Article.last.description).to eq "Jaunuma garais apraksts"
    expect(Education::Article.last.published).to eq true
    expect(Education::Article.count).to eq 2
  end

  it "Admin can create articles and set if it is top story" do
    click_link I18n.t('admin.education.articles.index.add_article')

    expect(page).to have_content I18n.t('admin.education.articles.new.new_article')

    fill_in Education::Article.human_attribute_name(:title), with: "Trešais jaunums"
    fill_in Education::Article.human_attribute_name(:description), with: "Trešā jaunuma apraksts"
    check Education::Article.human_attribute_name(:top_story)

    click_button I18n.t('save')

    expect(page).to have_content I18n.t('admin.education.articles.create.notice')
    expect(Education::Article.last.title).to eq "Trešais jaunums"
    expect(Education::Article.last.description).to eq "Trešā jaunuma apraksts"
    expect(Education::Article.last.top_story).to eq true
    expect(Education::Article.count).to eq 2
  end

  it "Creating article without filling title will show error" do
    click_link I18n.t('admin.education.articles.index.add_article')

    expect(page).to have_content I18n.t('admin.education.articles.new.new_article')

    fill_in Education::Article.human_attribute_name(:description), with: "Ceturtā jaunuma apraksts"

    click_button I18n.t('save')

    expect(page).to have_content I18n.t('error')
    expect(Education::Article.count).to eq 1
  end

  it "Creating article without filling description field will show error" do
    click_link I18n.t('admin.education.articles.index.add_article')

    expect(page).to have_content I18n.t('admin.education.articles.new.new_article')

    fill_in Education::Article.human_attribute_name(:title), with: "Ceturtais jaunums"

    click_button I18n.t('save')

    expect(page).to have_content I18n.t('error')
    expect(Education::Article.count).to eq 1
  end
end
