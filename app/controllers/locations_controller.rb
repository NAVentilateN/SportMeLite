class LocationsController < ApplicationController

  def index
    @filterrific = initialize_filterrific(
      Location.all, params[:filterrific],
      select_options: {
        with_sport: Location.options_for_sport_select
      },
      default_filter_params: {},
      available_filters: [:with_sport],
      sanitize_params: true
    ) || return
    @locations = @filterrific.find.select { |location| location.sports.count.positive? }
    respond_to do |format|
      format.html
      format.js
    end

    @markers = @locations.map do |location|
      {
        lat: location.lat,
        lng: location.long,
        info_window: render_to_string(partial: "info_window", locals: { location: location })
      }
    end
  end

  def show
    @location = Location.find(params[:id])
  end
end
