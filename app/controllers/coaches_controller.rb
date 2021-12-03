class CoachesController < ApplicationController
  def index
    sport = Sport.find(params[:sport_id])
    @coaches = sport.users
  end

  def show
    coach = User.find(params[:id])
  end
end
