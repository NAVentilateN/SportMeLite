module ApplicationHelper
  def coach_path?
    params[:controller].match?(/^(coach\/).*/)
  end

  def sport_icon(sport)
    if sport == 'soccer'
      'sports_soccer'
    elsif sport == 'badminton'
      'sports_tennis'
    elsif sport == 'tennis'
      'sports_tennis'
    elsif sport == 'swimming'
      'pool'
    elsif sport == 'basketball'
      'sports_basketball'
    end
  end
end

