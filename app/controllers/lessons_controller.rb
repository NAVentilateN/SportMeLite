class LessonsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    @lessons = current_user.lessons_to_attend
  end

  def make_booking
    @lesson = Lesson.find(params[:id])
    @lesson.student = current_user
    @lesson.status = true
    @lesson.save
    redirect_to lessons_path
  end
end
