class Admin::Education::EstimationsController < Admin::AdminController

  # GET admin/education/program_levels/[:id]/lessons/[:id]/estimations
  def index
    @estimations = ::Education::Estimation.all
    @lesson = ::Education::Lesson.find(params[:lesson_id])
    @program_level = ::Education::ProgramLevel.find(params[:program_level_id])
  end

  # DELETE admin/education/program_levels/[:id]/lessons/[:id]/estimations/[:id]
  def destroy
    lesson = ::Education::Lesson.find(params[:lesson_id])
    @estimation = ::Education::Estimation.find(params[:id])
    @estimation.destroy
    redirect_to admin_education_program_level_lesson_estimations_path(lesson.program_level, lesson), notice: t('.notice')
  end
end
