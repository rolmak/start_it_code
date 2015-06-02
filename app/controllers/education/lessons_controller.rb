class Education::LessonsController < Education::EducationController
  # GET education/program_levels/[:id]/lessons/[:id]
  def show
    @program_level = Education::ProgramLevel.find(params[:program_level_id])
    @lesson = Education::Lesson.find(params[:id])
  end
end
