module ApplicationHelper
  def coach_path?
    params[:controller].match?(/^(coach\/).*/)
  end
end
