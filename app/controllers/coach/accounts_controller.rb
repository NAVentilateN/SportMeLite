class Coach::AccountsController < ApplicationController
  def index
    all_lessons = current_user.lessons_to_teach
    @lessons = all_lessons.sort_by(&:start_date_time)
    @lessons_with_orders = all_lessons.select(&:order).sort_by { |lesson| lesson.order.created_at }

    @data = all_lessons.select(&:order).map(&:order)

  end

  def day
    all_lessons = current_user.lessons_to_teach
    @data = all_lessons.select(&:order).select { |lesson| lesson.order.created_at > 30.days.ago }.map(&:order)

    respond_to do |format|
      format.html
      format.text { render partial: 'coach/accounts/day_charts', formats: [:html] }
    end
  end

  def month
    all_lessons = current_user.lessons_to_teach
    @data = all_lessons.select(&:order).select { |lesson| lesson.order.created_at > 360.days.ago }.map(&:order)
    respond_to do |format|
      format.html
      format.text { render partial: 'coach/accounts/month_charts', formats: [:html] }
    end
  end

end
