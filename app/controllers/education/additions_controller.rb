class AdditionsController < Education::EducationController
  # POST education/program_levels/[:id]/lessons/[:id]/patterns/[:id]/feedbacks/[:id]/additions
  def create
    @addition = Addition.new(addition_params.merge(lesson_id: params[:lesson_id]))

    if @addition.save
      redirect_to lecture_path(@lecture), notice: "Fails veiksmīgi pievienots"
    else
      redirect_to lecture_path(@lecture), notice: "Failu neizdevās pievienot"
    end
  end

  # GET education/program_levels/[:id]/lessons/[:id]/patterns/[:id]/feedbacks/[:id]/additions[:id]
  def destroy
    @addition = Additions.find(params[:id])
    @addition.destroy
      redirect_to admin_education_program_level_lesson_pattern_url(@pattern.lesson.program_level, @pattern.lesson, @pattern)
  end

  private

  def addition_params
    params.require(:additions).permit(:name, :file, :feedback_id)
  end
end
