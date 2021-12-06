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

  def cancel_booking
    @lesson = Lesson.find(params[:id])
    @lesson.status = false
    @lesson.student = nil
    @lesson.save
    redirect_to lessons_path
  end

  def upcoming
    all_lessons = current_user.lessons_to_attend
    @lessons = all_lessons.select{ |lesson| lesson.end_date_time >= Time.now.to_datetime}
  end

  def history
    all_lessons = current_user.lessons_to_attend
    @lessons = all_lessons.select{ |lesson| lesson.end_date_time < Time.now.to_datetime}
  end
end
