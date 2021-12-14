module Coach
  class LessonsController < ApplicationController
    before_action :set_lesson, only: [:show, :edit, :update, :destroy]
    before_action :authorize_coach, only: [:index, :upcoming, :history]

    def index
      all_lessons = current_user.lessons_to_teach
      @lessons = all_lessons.sort_by(&:start_date_time)
      @lessons_json = all_lessons.map { |lesson| lesson.to_json}
      @lesson = Lesson.new
    end

    def show
    end

    def new
      @lesson = Lesson.new
    end

    def create
      @lesson = Lesson.new(lesson_params)
      @lesson.coach = current_user
      @lesson.status = false
      # @lesson.start_date_time = set_time_zone(@lesson.start_date_time)
      # @lesson.end_date_time = set_time_zone(@lesson.end_date_time)
      if @lesson.save
       redirect_to action: 'index'
      else
       redirect_to action: 'index'
      end
    end

    def edit
    end

    def update
      @lesson.update(lesson_params)
      redirect_to action: 'index'
    end

    def destroy
      @lesson.destroy
      redirect_to action: 'index'
    end

    def upcoming
      @lesson = Lesson.new
      all_lessons = current_user.lessons_to_teach
      @lessons_json = all_lessons.map { |lesson| lesson.to_json}
      @lessons = all_lessons.select{ |lesson| lesson.end_date_time >= Time.now.to_datetime}.sort_by { |lesson| lesson.start_date_time }
    end

    def history
      @lesson = Lesson.new
      all_lessons = current_user.lessons_to_teach
      @lessons_json = all_lessons.map { |lesson| lesson.to_json}
      @lessons = all_lessons.select{ |lesson| lesson.end_date_time < Time.now.to_datetime}.sort_by { |lesson| lesson.start_date_time }
    end

    private

    def lesson_params
      params.require(:lesson).permit(:start_date_time, :end_date_time, :location, :price, :description)
    end

    def authorize_coach
      policy_scope([:coach, Lesson])
      authorize([:coach, Lesson])
    end

    def set_lesson
      @lesson = Lesson.find(params[:id])
      authorize([:coach, @lesson])
    end

    def set_time_zone(time)
      Time.use_zone(current_user.time_zone, time)
    end
  end
end
