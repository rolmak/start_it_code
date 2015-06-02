class Admin::Education::LessonsController < Admin::AdminController
  before_action :set_lesson, only: [:show, :edit, :update, :destroy]

  # GET admin/education/program_levels/[:id]/lessons/[:id]
  def show
    program_level = ::Education::ProgramLevel.find(params[:program_level_id])
    @lesson = program_level.lessons.find(params[:id])
    @sorted_patterns = @lesson.patterns.sort_by { |elem| elem.sequence }
  end

  # GET admin/education/program_levels/[:id]/lessons/new
  def new
    program_level = ::Education::ProgramLevel.find(params[:program_level_id])
    @lesson = program_level.lessons.build
  end

  # GET admin/education/program_levels/[:id]/lessons/[:id]/edit
  def edit
    program_level = ::Education::ProgramLevel.find(params[:program_level_id])
    @lesson = program_level.lessons.find(params[:id])
  end

  # POST admin/education/program_levels/[:id]/lessons
  def create
    program_level = ::Education::ProgramLevel.find(params[:program_level_id])
    @lesson = program_level.lessons.create(lesson_params)

    if @lesson.save
      redirect_to admin_education_program_level_path(params[:program_level_id]), notice: t('.notice')
    else
      render action: :new
    end
  end

  # PATCH/PUT admin/education/program_levels/[:id]/lessons/[:id]
  def update
    program_level = ::Education::ProgramLevel.find(params[:program_level_id])
    @lesson = program_level.lessons.find(params[:id])
    if @lesson.update(lesson_params)
      redirect_to admin_education_program_level_path(params[:program_level_id]), notice: t('.notice')
    else
      render action: :edit
    end
  end

  # DELETE admin/education/program_levels/[:id]/lessons/[:id]
  def destroy
    program_level = ::Education::ProgramLevel.find(params[:program_level_id])
    @lesson = program_level.lessons.find(params[:id])
    @lesson.destroy
    redirect_to admin_education_program_level_path(params[:program_level_id]), notice: t('.notice')
  end

  private

    def set_lesson
      @lesson = ::Education::Lesson.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def lesson_params
      params.require(:education_lesson).permit(
        :program_level_id, :name, :code, :teacher_material, :pupil_material,
          :sequence, :plan, :step, :news,
        estimations_attributes: [:id, :user_id, :lesson_id, :text],
        additions_attributes: [:id, :name, :file, :feedback_id],
        patterns_attributes: [:id, :name, :sequence, :_destroy,
          exercises_attributes: [:id, :name, :description, :_destroy],
          assignments_attributes: [:id, :name, :description, :_destroy],
          feedbacks_attributes: [:id, :user_id, :pattern_id, :text,
            additions_attributes: [:id, :name, :file, :feedback_id]
          ]
        ]
      )
    end
end
