class SportsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @query = params['search']['query'].downcase unless params['search'].nil?
    if @query
      @sports_heading = 'Search Results'
      @sports = Sport.where("name LIKE ?", "%#{@query}%")
    else
      @sports_heading = 'All Sports'
      @sports = Sport.all
    end
  end

  def show
    @lessons = Lesson.where(location: params[:location_id], sport: params[:id])
  end
end
