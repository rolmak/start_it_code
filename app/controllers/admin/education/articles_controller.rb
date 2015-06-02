class Admin::Education::ArticlesController < Admin::AdminController
  before_action :set_article, only: [:edit, :update, :destroy]

  # GET admin/education/articles
  def index
    @top_story_articles = ::Education::Article.where(top_story: true).order(published_at: :desc).page params[:page]
    @articles = ::Education::Article.where(top_story: false).order(published_at: :desc).page params[:page]
  end

  # GET admin/education/articles/new
  def new
    @article = ::Education::Article.new
  end

  # GET admin/education/articles/[:id]/new
  def edit
  end

  # POST admin/education/articles/
  def create
    @article = ::Education::Article.new(article_params)

    if @article.save
      redirect_to admin_education_articles_path, notice: t('.notice')
    else
      render action: :new
    end
  end

  # PATCH/PUT admin/education/articles/[:id]
  def update
    if @article.update(article_params)
      redirect_to admin_education_articles_path, notice: t('.notice')
    else
      render action: :edit
    end
  end

  # DELETE /articles/[:id]
  def destroy
    @article.destroy
    redirect_to admin_education_articles_path, notice: t('.notice')
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = ::Education::Article.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def article_params
      params.require(:education_article).permit(
        :title, :description, :published, :top_story, :published_at
      )
    end
end
