class LessonsController < ApplicationController
  # skip_before_action :authenticate_user!, only: :index

  def index
    coach = User.find(params[:coach_id])
    @lessons = coach.lessons_to_teach
  end
end
