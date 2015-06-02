class Admin::Education::ProgramsController < Admin::AdminController
  before_action :set_program, only: [:show, :edit, :update, :destroy]

  # GET admin/education/programs
  def index
    @programs = ::Education::Program.all
  end

  # GET admin/education/programs/[:id]
  def show
    @program_levels = @program.program_levels
    @sorted_levels = @program_levels.sort_by { |elem| elem.level.sequence }
  end

  # GET admin/education/programs/new
  def new
    @program = ::Education::Program.new
    @levels = ::Education::Level.order("sequence asc")
  end

  # GET admin/education/programs/[:id]/edit
  def edit
    @levels = ::Education::Level.order("sequence asc")
    @sorted_levels = @program.program_levels.sort_by { |elem| elem.level.sequence }
  end

  # POST admin/education/programs
  def create
    @program = ::Education::Program.new(program_params)

    if @program.save
      redirect_to admin_education_programs_path, notice: t('.notice')
    else
      render action: :new
    end
  end

  # PATCH/PUT admin/education/programs/[:id]
  def update
    if @program.update(program_params)
      redirect_to admin_education_programs_path, notice: t('.notice')
    else
      render action: :edit
    end
  end

  # DELETE admin/education/programs/[:id]
  def destroy
    @program.destroy
    redirect_to admin_education_programs_path, notice: t('.notice')
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_program
      @program = ::Education::Program.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def program_params
      params.require(:education_program).permit(:name,
        levels_attributes: [:id, :name, :sequence, :program_ids]
      )
    end
end
