class Admin::Education::PatternsController < Admin::AdminController
  before_action :set_pattern, only: [:edit, :update, :destroy]

  # GET admin/education/program_levels/[:id]/lessons/[:id]/patterns/[:id]
  def show
    program_level = ::Education::ProgramLevel.find(params[:program_level_id])
    @lesson = program_level.lessons.find(params[:lesson_id])
    @pattern = @lesson.patterns.find(params[:id])
    @sorted_assignments = @pattern.assignments.sort_by { |elem| elem.sequence }
    @sorted_exercises = @pattern.exercises.sort_by { |elem| elem.sequence }
  end

  # GET admin/education/program_levels/[:id]/lessons/[:id]/patterns/[:id]
  def new
    program_level = ::Education::ProgramLevel.find(params[:program_level_id])
    @lesson = program_level.lessons.find(params[:lesson_id])
    @pattern = @lesson.patterns.build
  end

  # GET admin/education/program_levels/[:id]/lessons/[:id]/patterns/[:id]/edit
  def edit
    program_level = ::Education::ProgramLevel.find(params[:program_level_id])
    @lesson = program_level.lessons.find(params[:lesson_id])
    @pattern = @lesson.patterns.find(params[:id])
  end

  # POST admin/education/program_levels/[:id]/lessons/[:id]/patterns
  def create
    program_level = ::Education::ProgramLevel.find(params[:program_level_id])
    @lesson = program_level.lessons.find(params[:lesson_id])
    @pattern = @lesson.patterns.create(pattern_params)
    if @pattern.save
      redirect_to admin_education_program_level_lesson_path(@lesson.program_level, @lesson), notice: t('.notice')
    else
      render action: :new
    end
  end

  # PATCH/PUT admin/education/program_levels/[:id]/lessons/[:id]/patterns/[:id]
  def update
    program_level = ::Education::ProgramLevel.find(params[:program_level_id])
    @lesson = program_level.lessons.find(params[:lesson_id])
    @pattern = @lesson.patterns.find(params[:id])
    if @pattern.update(pattern_params)
      redirect_to admin_education_program_level_lesson_path(@lesson.program_level, @lesson), notice: t('.notice')
    else
      render action: :edit
    end
  end

  # DELETE admin/education/program_levels/[:id]/lessons/[:id]/patterns/[:id]
  def destroy
    program_level = ::Education::ProgramLevel.find(params[:program_level_id])
    @lesson = program_level.lessons.find(params[:lesson_id])
    @pattern = @lesson.patterns.find(params[:id])
    @pattern.destroy
    redirect_to admin_education_program_level_lesson_path(@lesson.program_level, @lesson), notice: t('.notice')
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pattern
      @pattern = ::Education::Pattern.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def pattern_params
      params.require(:education_pattern).permit( :lesson_id, :name, :sequence, :video,
        exercises_attributes: [:id, :name, :description, :_destroy],
        assignments_attributes: [:id, :name, :description, :_destroy],
        feedbacks_attributes: [:id, :user_id, :pattern_id, :text,
          additions_attributes: [:id, :name, :file, :feedback_id]
        ]
      )
    end
end
