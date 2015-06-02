class Education::ProgramsController < Education::EducationController

  # GET education/program_levels/[:id]/lessons
  def index
    @programs = Education::Program.all
  end
end
