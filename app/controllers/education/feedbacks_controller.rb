class Education::FeedbacksController < Education::EducationController
  before_filter :teacher_required, only: [:index, :show]

  # GET education/program_levels/[:id]/lessons/[:id]/patterns/[:id]/feedbacks
  def index
    @pattern = ::Education::Pattern.find(params[:pattern_id])
    @feedbacks = @pattern.feedbacks
    @program_level = Education::ProgramLevel.find(params[:program_level_id])
    @lesson = @program_level.lessons.find(params[:lesson_id])
  end

  # GET education/program_levels/[:id]/lessons/[:id]/patterns/[:id]/feedbacks/[:id]
  def show
    @program_level = Education::ProgramLevel.find(params[:program_level_id])
    @lesson = @program_level.lessons.find(params[:lesson_id])
    @feedback = Education::Feedback.find(params[:id])
    @user = User.find(@feedback.user_id)
  end

  # POST education/program_levels/[:id]/lessons/[:id]/patterns/[:id]/feedbacks
  def create
    program_level = Education::ProgramLevel.find(params[:program_level_id])
    @lesson = program_level.lessons.find(params[:lesson_id])
    @pattern = @lesson.patterns.find(params[:pattern_id])
    @feedback = @pattern.feedbacks.create(feedback_params.merge(user_id: current_user.id, pattern_id: params[:pattern_id]))

    if @feedback.save
      redirect_to education_program_level_lesson_path(@lesson.program_level, @lesson), notice: t('.notice')
    else
      redirect_to education_program_level_lesson_path(@lesson.program_level, @lesson), alert: t('.alert')
    end
  end

  private

    def feedback_params
      params.require(:education_feedback).permit(:user_id, :pattern_id, :message,
        additions_attributes: [:id, :lesson_id, :exercise_id, :assignment_id,
          :name, :file, :_destroy],
      )
    end

    # User must be teacher to see feedbacks
    def teacher_required
      unless current_user.is_teacher == true
        redirect_to education_path
      end
    end
end
