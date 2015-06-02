class Admin::Education::ProgramLevelsController < Admin::AdminController
  before_action :set_program_level, only: [:show]

  # GET admin/education/program_levels/[:id]
  def show
    @program = @program_level.program
    @level = @program_level.level
    @lessons = @program_level.lessons
    @sorted_lessons = @lessons.sort_by { |elem| elem.sequence }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_program_level
      @program_level = ::Education::ProgramLevel.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def program_level_params
      params.require(:education_program_level).permit(:program_id, :level_id,
        lessons_attributes: [:id, :name, :sequence, :program_level_id,
          :plan, :step, :teacher_material, :pupil_material,
          estimations_attributes: [:id, :user_id, :lesson_id, :text],
          additions_attributes: [:id, :name, :file, :lesson_id, :feedback_id,
             :assignment_id, :exercise_id],
          patterns_attributes: [ :id, :lesson_id, :name, :sequence,
            exercises_attributes: [:id, :description, :_destroy],
            assignments_attributes: [:id, :description, :_destroy],
            feedbacks_attributes: [:id, :user_id, :pattern_id, :text,
              additions_attributes: [:id, :name, :file, :feedback_id]
            ]
          ]
        ],
        teacher_program_levels_attributes: [:id, :user_id, :program_level_id, :_destroy],
        users_attributes: [:id, :program_level_ids]
      )
    end

end
