class Admin::Education::ExercisesController < Admin::AdminController
  before_action :set_exercise, only: [:edit, :update, :destroy]

  # GET admin/education/program_levels/[:id]/lessons/[:id]/patterns/[:id]/exercises/new
  def new
    program_level = ::Education::ProgramLevel.find(params[:program_level_id])
    @lesson = program_level.lessons.find(params[:lesson_id])
    @pattern = @lesson.patterns.find(params[:pattern_id])
    @exercise = @pattern.exercises.build
  end

  # GET admin/education/program_levels/[:id]/lessons/[:id]/patterns/[:id]/exercises/[:id]/edit
  def edit
  end

  # POST admin/education/program_levels/[:id]/lessons/[:id]/patterns/[:id]/exercises
  def create
    program_level = ::Education::ProgramLevel.find(params[:program_level_id])
    @lesson = program_level.lessons.find(params[:lesson_id])
    @pattern = @lesson.patterns.find(params[:pattern_id])
    @exercise = @pattern.exercises.create(exercise_params)
    if @exercise.save
      redirect_to admin_education_program_level_lesson_pattern_path(@pattern.lesson.program_level, @pattern.lesson, @pattern), notice: t('.notice')
    else
      render action: :new
    end
  end

  # PATCH/PUT admin/education/program_levels/[:id]/lessons/[:id]/patterns/[:id]/exercises/[:id]
  def update
    program_level = ::Education::ProgramLevel.find(params[:program_level_id])
    @lesson = program_level.lessons.find(params[:lesson_id])
    @pattern = @lesson.patterns.find(params[:pattern_id])
    @exercise = @pattern.exercises.find(params[:id])
    if @exercise.update(exercise_params)
      redirect_to admin_education_program_level_lesson_pattern_path(@pattern.lesson.program_level, @pattern.lesson, @pattern), notice: t('.notice')
    else
      render action: :edit
    end
  end

  # DELETE admin/education/program_levels/[:id]/lessons/[:id]/patterns/[:id]/exercises/[:id]
  def destroy
    program_level = ::Education::ProgramLevel.find(params[:program_level_id])
    @lesson = program_level.lessons.find(params[:lesson_id])
    @pattern = @lesson.patterns.find(params[:pattern_id])
    @exercise = @pattern.exercises.find(params[:id])
    @exercise.destroy
      redirect_to admin_education_program_level_lesson_pattern_path(@pattern.lesson.program_level, @pattern.lesson, @pattern), notice: t('.notice')
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_exercise
      @exercise = ::Education::Exercise.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def exercise_params
      params.require(:education_exercise).permit(
        :pattern_id, :name, :sequence, :description, :_destroy
      )
    end
end
