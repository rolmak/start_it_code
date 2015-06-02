class Education::EstimationsController < ApplicationController
  # GET /education/program_levels/[:id]/lessons/[:id]/estimations/new
  def new
    program_level = Education::ProgramLevel.find(params[:program_level_id])
    @lesson = program_level.lessons.find(params[:lesson_id])
    @estimation = @lesson.estimations.build
  end

  # POST /education/program_levels/[:id]/lessons/[:id]/estimations
  def create
    program_level = Education::ProgramLevel.find(params[:program_level_id])
    @lesson = program_level.lessons.find(params[:lesson_id])
    @estimation = @lesson.estimations.create(estimation_params.merge(user_id: current_user.id, lesson_id: params[:lesson_id]))
    if @estimation.save
      redirect_to education_program_level_lesson_path(@lesson.program_level, @lesson), notice: t('.notice')
    else
      redirect_to education_program_level_lesson_path(@lesson.program_level, @lesson), alert: t('.alert')
    end
  end

  private

    # Only allow a trusted parameter "white list" through.
    def estimation_params
      params.require(:education_estimation).permit(
        :user_id, :lesson_id, :message, :_destroy,
      )
    end
end
