class Coach::AccountsController < ApplicationController
  def index
    all_lessons = current_user.lessons_to_teach
    @lessons = all_lessons.sort_by(&:start_date_time)
    @lessons_with_orders = all_lessons.select(&:order).sort_by { |lesson| lesson.order.created_at }
  end
end
