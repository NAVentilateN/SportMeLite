class CoachesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show, :list_lessons]
  before_action :get_coach, only: [:show, :bookmark_coach, :unbookmark_coach]

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
    @coaches = @filterrific.find.select { |coach| coach.lessons_to_teach.count.positive? }.sort_by(&:name)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
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
    @lessons = @filterrific.find.select { |lesson| lesson.start_date_time > Date.today && !lesson.status }.sort_by(&:start_date_time)
    @reviews = @coach.lessons_to_teach.map(&:review).compact
    respond_to do |format|
      format.html
      format.js
    end
  end

  def bookmark_coach
    if current_user.favorited?(@coach)
      current_user.unfavorite(@coach)
    else
      current_user.favorite(@coach)
    end
    redirect_to coach_path(@coach)
  end

  private

  def get_coach
    @coach = User.find(params[:id])
  end
end
