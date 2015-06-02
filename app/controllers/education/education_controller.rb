class Education::EducationController < ApplicationController
  layout "education"

  before_filter :authenticate_user!, :set_all_programs

  # All programs for education layout
  def set_all_programs
    @programs = Education::Program.all
  end
end
