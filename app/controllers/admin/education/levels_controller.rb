class Admin::Education::LevelsController < Admin::AdminController
  before_action :set_level, only: [:edit, :update, :destroy]

  # GET admin/education/levels
  def index
    @levels = ::Education::Level.order(sequence: :asc)
  end

  # GET admin/education/levels/new
  def new
    @level = ::Education::Level.new
  end

  # GET admin/education/levels/[:id]/edit
  def edit
  end

  # POST admin/education/levels
  def create
    @level = ::Education::Level.new(level_params)

    if @level.save
      redirect_to admin_education_levels_path, notice: t('.notice')
    else
      render action: :new
    end
  end

  # PATCH/PUT admin/education/levels/[:id]
  def update
    if @level.update(level_params)
      redirect_to admin_education_levels_path, notice: t('.notice')
    else
      render action: :edit
    end
  end

  # DELETE admin/education/levels/[:id]
  def destroy
    @level.destroy
    redirect_to admin_education_levels_path, notice: t('.notice')
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_level
      @level = ::Education::Level.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def level_params
      params.require(:education_level).permit(:name, :sequence, :program_ids => [])
    end
end
