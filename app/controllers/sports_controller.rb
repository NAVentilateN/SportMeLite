class SportsController < ApplicationController
  def index
    @query = params['search']['query'] unless params['search'].nil?
    if @query
      @sports_heading = 'Search Results'
      @sports = Sport.where("name ILIKE ?", "%#{@query}%")
    else
      @sports_heading = 'All Sports'
      @sports = Sport.all
    end
  end
end
