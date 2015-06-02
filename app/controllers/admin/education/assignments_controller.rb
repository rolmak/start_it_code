class Admin::Education::AssignmentsController < Admin::AdminController
  before_action :set_assignment, only: [:edit, :update, :destroy]

  # GET admin/education/program_levels/[:id]/lessons/[:id]/patterns/[:id]/assignments/new
  def new
    program_level = ::Education::ProgramLevel.find(params[:program_level_id])
    @lesson = program_level.lessons.find(params[:lesson_id])
    @pattern = @lesson.patterns.find(params[:pattern_id])
    @assignment = @pattern.assignments.build
  end

  # GET admin/education/program_levels/[:id]/lessons/[:id]/patterns/[:id]/assignments/[:id]/edit
  def edit
    program_level = ::Education::ProgramLevel.find(params[:program_level_id])
    @lesson = program_level.lessons.find(params[:lesson_id])
    @pattern = @lesson.patterns.find(params[:pattern_id])
    @assignment = @pattern.assignments.find(params[:id])
  end

  # POST admin/education/program_levels/[:id]/lessons/[:id]/patterns/[:id]/assignments
  def create
    program_level = ::Education::ProgramLevel.find(params[:program_level_id])
    @lesson = program_level.lessons.find(params[:lesson_id])
    @pattern = @lesson.patterns.find(params[:pattern_id])
    @assignment = @pattern.assignments.create(assignment_params)
    if @assignment.save
      redirect_to admin_education_program_level_lesson_pattern_path(@pattern.lesson.program_level, @pattern.lesson, @pattern), notice: t('.notice')
    else
      render action: :new
    end
  end

  # PATCH/PUT admin/education/program_levels/[:id]/lessons/[:id]/patterns/[:id]/assignments/[:id]
  def update
    program_level = ::Education::ProgramLevel.find(params[:program_level_id])
    @lesson = program_level.lessons.find(params[:lesson_id])
    @pattern = @lesson.patterns.find(params[:pattern_id])
    @assignment = @pattern.assignments.find(params[:id])
    if @assignment.update(assignment_params)
      redirect_to admin_education_program_level_lesson_pattern_path(@pattern.lesson.program_level, @pattern.lesson, @pattern), notice: t('.notice')
    else
      render action: :edit
    end
  end

  # DELETE admin/education/program_levels/[:id]/lessons/[:id]/patterns/[:id]/assignments/[:id]
  def destroy
    program_level = ::Education::ProgramLevel.find(params[:program_level_id])
    @lesson = program_level.lessons.find(params[:lesson_id])
    @pattern = @lesson.patterns.find(params[:pattern_id])
    @assignment = @pattern.assignments.find(params[:id])
    @assignment.destroy
      redirect_to admin_education_program_level_lesson_pattern_path(@pattern.lesson.program_level, @pattern.lesson, @pattern), notice: t('.notice')
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_assignment
      @assignment = ::Education::Assignment.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def assignment_params
      params.require(:education_assignment).permit(
        :pattern_id, :name, :sequence, :description, :_destroy
      )
    end
end
