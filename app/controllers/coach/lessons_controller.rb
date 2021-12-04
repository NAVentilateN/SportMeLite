module Coach
  class LessonsController < ApplicationController
    before_action :set_lesson, only: [:show, :edit, :update, :destroy]
    before_action :authorize_coach, only: [:index]

    def index
      @lessons = current_user.lessons_to_teach
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
      @lessons = all_lessons.select{ |lesson| lesson.end_date_time >= Time.now.to_datetime}
    end

    def past
      all_lessons = current_user.lessons_to_teach
      @lessons = all_lessons.select{ |lesson| lesson.end_date_time < Time.now.to_datetime}
    end

    private

    def lesson_params
      params.require(:lesson).permit(:start_date_time, :end_date_time, :location, :price, :description)
    end

    def authorize_coach
      policy_scope([:coach, Lesson])
      authorize ([:coach, Lesson])
    end

    def set_lesson
      @lesson = Lesson.find(params[:id])
      authorize([:coach, @lesson])
    end
  end
end
