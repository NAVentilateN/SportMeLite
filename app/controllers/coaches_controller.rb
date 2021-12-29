class CoachesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show, :list_lessons]

  def index
    @sport = Sport.find(params[:sport_id])
    # @coaches = @sport.users

    @filterrific = initialize_filterrific(
      @sport.users, params[:filterrific],
      select_options: {
        with_gender: User.options_for_select,
        sorted_by: User.options_for_sorted_by
      },
      default_filter_params: {},
      available_filters: [:sorted_by, :with_gender],
      sanitize_params: true
    ) || return
    # Get an ActiveRecord::Relation for all students that match the filter settings.
    # You can paginate with will_paginate or kaminari.
    # NOTE: filterrific_find returns an ActiveRecord Relation that can be
    # chained with other scopes to further narrow down the scope of the list,
    # e.g., to apply permissions or to hard coded exclude certain types of records.
    @coaches = @filterrific.find.select { |coach| coach.lessons_to_teach.count.positive? }

    # .select { |user| user.sport == Sport.find(params[:sport_id]) }

    # @coaches = @filterrific.find.page(params[:page])
    respond_to do |format|
      format.html
      format.js
    end
  # rescue ActiveRecord::RecordNotFound => e
  #   # There is an issue with the persisted param_set. Reset it.
  #   puts "Had to reset filterrific params: #{e.message}"
  #   redirect_to(reset_filterrific_url(format: :html)) && return
  end


  def show
    @coach = User.find(params[:id])
    @lessons = @coach.lessons_to_teach
                     .select { |lesson| lesson.start_date_time > Date.today }
                     .sort_by(&:start_date_time)
    @reviews = @coach.lessons_to_teach.map(&:review).compact
    @chats = @coach.chats_with_student
    @chat = Chat.new
  end
end
