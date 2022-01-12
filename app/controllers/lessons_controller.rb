class LessonsController < ApplicationController

  def index
    all_lessons = current_user.lessons_to_attend
    @lessons = all_lessons.sort_by { |lesson| lesson.start_date_time }
    respond_to do |format|
      format.html
      format.text { render partial: 'lessons/lessons_list', formats: [:html] }
    end
  end

  def show
    @lesson = Lesson.find(params[:id])
    respond_to do |format|
      format.html
      format.text { render partial: '/lessons/show', locals: { lesson: @lesson }, formats: [:html] }
    end
  end

  def make_booking
    @lesson = Lesson.find(params[:id])
    @lesson.student = current_user
    @lesson.status = true
    @lesson.save
    Notification.create(recipient: @lesson.coach, sender: current_user, action: "New booking from", notifiable: @lesson)
    redirect_to lessons_path
  end

  def cancel_booking
    @lesson = Lesson.find(params[:id])
    @lesson.status = false
    @lesson.student = nil
    @lesson.save
    Notification.create(recipient: @lesson.coach, sender: current_user, action: "Booking cancellation from", notifiable: @lesson)
    redirect_to lessons_path
  end

  def upcoming
    all_lessons = current_user.lessons_to_attend
    @lessons = all_lessons
    .select{ |lesson| lesson.end_date_time >= Time.now.to_datetime}
    .sort_by { |lesson| lesson.start_date_time }
    respond_to do |format|
      format.html
      format.text { render partial: 'lessons/lessons_list', formats: [:html] }
    end
  end

  def history
    all_lessons = current_user.lessons_to_attend
    @lessons = all_lessons
    .select{ |lesson| lesson.end_date_time < Time.now.to_datetime}
    .sort_by { |lesson| lesson.start_date_time }
    respond_to do |format|
      format.html
      format.text { render partial: 'lessons/lessons_list', formats: [:html] }
    end
  end

  def location_lessons
    @location = Location.find(params[:location_id])
    @lessons = @location.lessons
    respond_to do |format|
      format.html
      format.text { render partial: 'lessons/location_lesson_list', formats: [:html] }
    end
  end
end
