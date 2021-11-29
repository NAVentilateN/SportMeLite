class LessonsController < ApplicationController
  before_action :set_lesson, only: [:show, :edit, :update, :destroy]

  def index
    @lessons = Lesson.where(current_user.id = coach_id)
  end

  def new
    # @user = current_user
    @lesson = Lesson.new
  end

  def create
    @lesson = Lesson.new(lesson_params)
    # @user = current_user
    @lesson.coach_id = current_user
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

  private

   def lesson_params
    params.require(:lesson).permit(:start_time, :end_time, :location, :price)
  end

  def set_lesson
    @lesson = Lesson.find(params[:id])
  end
end
