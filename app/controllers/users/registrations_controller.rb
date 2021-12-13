class Users::RegistrationsController < Devise::RegistrationsController
  def destroy
    if check_active_lessons?
      redirect_to root_path, alert: "You can't delete your account"
    else
      super
    end
  end

  private

  def check_active_lessons?
    current_user.lessons_to_teach.each do |lesson|
      return true if lesson.start_date_time > Date.today && lesson.status
    end
  end
end
