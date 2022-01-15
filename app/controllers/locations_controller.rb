class LocationsController < ApplicationController

  def index
    @filterrific = initialize_filterrific(
      Location.with_active_lessons,
      params[:filterrific],
      select_options: {
        with_sport: Location.options_for_sport_select
      },
      default_filter_params: {},
      available_filters: [:with_sport],
      sanitize_params: true
    ) || return
    if @filterrific.with_sport.nil?
      @locations = @filterrific.find
    else
      @locations = @filterrific.find.select { |location| location.sports.map(&:name).include? (@filterrific.with_sport) }
    end

    @markers = @locations.map do |location|
      {
        lat: location.lat,
        lng: location.long,
        info_window: render_to_string(partial: "info_window", locals: { location: location })
      }
    end

    respond_to do |format|
      format.html #if the html already exist
      format.js
    end
  end
end
