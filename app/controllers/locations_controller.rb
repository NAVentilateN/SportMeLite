class LocationsController < ApplicationController

  def index
    @filterrific = initialize_filterrific(
      Location,
      params[:filterrific],
      select_options: {
        with_sport: Location.options_for_sport_select,
        with_location: Location.options_for_location_select
      },
      default_filter_params: {},
      available_filters: [:with_sport, :with_location],
      sanitize_params: true
    ) || return
    @locations = @filterrific.find.select { |location| location.lessons.count.positive? }

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
