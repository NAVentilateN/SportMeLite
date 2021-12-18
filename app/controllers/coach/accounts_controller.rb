class Coach::AccountsController < ApplicationController
  def index
    all_lessons = current_user.lessons_to_teach
    @lessons = all_lessons.sort_by(&:start_date_time)
  end
end
