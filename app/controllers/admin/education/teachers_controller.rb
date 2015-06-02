class Admin::Education::TeachersController < Admin::AdminController
  before_action :set_teacher, only: [:edit, :update]

  # GET admin/education/teachers
  def index
    @teachers = User.where(is_teacher: true).page params[:page]
    @teacher_count = User.where(is_teacher: true).count
  end

  # GET admin/education/teachers/[:id]/edit
  def edit
    @all_program_levels = ::Education::ProgramLevel.joins(:level).
      order("#{::Education::Level.table_name}.sequence ASC")
    @teacher = User.find(params[:id])
  end

  # POST admin/education/teachers
  def update
    if @teacher.update(teacher_params)
      redirect_to admin_education_teachers_path, notice: t('.notice')
    else
      render action: :edit
    end
  end

  private

  def set_teacher
    @teacher = User.find(params[:id])
  end

  def teacher_params
    params.require(:user).permit(:program_level_ids => [])
  end
end
