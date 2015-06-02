class Education::ArticlesController < Education::EducationController
  # GET education/articles
  def index
    @top_story_articles = ::Education::Article.where(top_story: true).order(published_at: :desc).page params[:page]
    @articles = ::Education::Article.where(top_story: false).order(published_at: :desc).page params[:page]
  end
end
