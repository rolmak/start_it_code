class Admin::Education::TeacherProgramLevelsController < Admin::AdminController
  before_action :set_teacher_program_level, only: [:show, :edit, :update, :destroy]

  # GET /teacher_program_levels
  def index
    @teacher_program_levels = ::Education::TeacherProgramLevel.order("sequence asc").page params[:page]
  end

  # GET /teacher_program_levels/[:id]
  def show
  end

  # GET /teacher_program_levels/new
  def new
    @teacher_program_level = ::Education::TeacherProgramLevel.new
  end

  # POST /teacher_program_levels
  def create
    @teacher_program_level = ::Education::TeacherProgramLevel.new(teacher_program_level_params)

    if @teacher_program_level.save
      redirect_to admin_education_teacher_program_level_path(params[:teacher_program_level_id]), notice: t('.notice')
    else
      render action: :new
    end
  end

  # PATCH/PUT /teacher_program_levels/[:id]
  def update
    if @teacher_program_level.update(teacher_program_level_params)
      redirect_to admin_education_teacher_program_level_path(params[:teacher_program_level_id]), notice: t('.notice')
    else
      render action: :edit
    end
  end

  # DELETE /program_levels/1
  def destroy
    @teacher_program_level.destroy
    redirect_to admin_education_teacher_program_level_path(params[:teacher_program_level_id]), notice: t('.notice')
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_teacher_program_level
      @teacher_program_level = ::Education::TeacherProgramLevel.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def teacher_program_level_params
      params.require(:education_teacher_program_level).permit(:user_id, :program_level_id)
    end

end
