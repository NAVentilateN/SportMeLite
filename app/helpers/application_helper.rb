module ApplicationHelper
  def coach_path?
    params[:controller].match?(/^(coach\/).*/) || current_user.coach_profile && current_page?(user_coach_profile_path(current_user, current_user.coach_profile))
  end
end
