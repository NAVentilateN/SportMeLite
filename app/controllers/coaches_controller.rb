class CoachesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show, :list_lessons]

  def index
    @sport = Sport.find(params[:sport_id])
    @coaches = @sport.users
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
