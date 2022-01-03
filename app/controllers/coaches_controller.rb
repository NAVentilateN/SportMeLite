class CoachesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show, :list_lessons]

  def index
    @sport = Sport.find(params[:sport_id])
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
    @coaches = @filterrific.find.select { |coach| coach.lessons_to_teach.count.positive? }
    respond_to do |format|
      format.html
      format.js
    end
  end


  def show
    @coach = User.find(params[:id])

    @chats = @coach.chats_with_student
    @chat = Chat.new

    @filterrific = initialize_filterrific(
      @coach.lessons_to_teach, params[:filterrific],
      select_options: {
        with_location_name: Lesson.options_for_select(params[:id]),
        sorted_by: Lesson.options_for_sorted_by
      },
      default_filter_params: {},
      available_filters: [:sorted_by, :with_location_name],
      sanitize_params: true
    ) || return
    @lessons = @filterrific.find.select { |lesson| lesson.start_date_time > Date.today && !lesson.status }
    @reviews = @coach.lessons_to_teach.map(&:review).compact
    respond_to do |format|
      format.html
      format.js
    end
  end
end
