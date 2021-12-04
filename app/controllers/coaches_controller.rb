class CoachesController < ApplicationController
  def index
    sport = Sport.find(params[:sport_id])
    @coaches = sport.users
  end

  def show
    @coach = User.find(params[:id])
  end

  def list_lessons
    @coach = User.find(params[:id])
    @lessons = @coach.lessons_to_teach
  end
end
