module Coach
  class LessonsController < ApplicationController
    before_action :set_lesson, only: [:show, :edit, :update, :destroy]
    before_action :authorize_coach, only: [:index, :upcoming, :history]

    def index
      all_lessons = current_user.lessons_to_teach
      @lessons = all_lessons.sort_by(&:start_date_time)
    end

    def show
    end

    def new
      @lesson = Lesson.new
      @locations = Location.all.uniq.sort_by(&:name)
    end

    def create
      @lesson = Lesson.new(lesson_params)
      @lesson.coach = current_user
      @lesson.status = false
      if @lesson.save
       redirect_to action: 'index'
      else
        render :new
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
      all_lessons = current_user.lessons_to_teach
      @lessons = all_lessons.select{ |lesson| lesson.end_date_time >= Time.now.to_datetime}.sort_by { |lesson| lesson.start_date_time }
    end

    def history
      all_lessons = current_user.lessons_to_teach
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
  end
end
