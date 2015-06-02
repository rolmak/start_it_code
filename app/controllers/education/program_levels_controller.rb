class Education::ProgramLevelsController < Education::EducationController

  # GET education/program_levels/[:id]/lessons
  def show
    @program_level = Education::ProgramLevel.find(params[:id])
    @lessons = @program_level.lessons
    @sorted_lessons = @lessons.sort_by { |elem| elem.sequence }
  end
end
