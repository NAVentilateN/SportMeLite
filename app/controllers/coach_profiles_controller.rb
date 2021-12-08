class CoachProfilesController < ApplicationController

  def new
    @coach_profile = CoachProfile.new
    @user = current_user
  end

  def create
    @coach_profile = CoachProfile.new(coach_profile_params)
    @user = current_user
    @coach_profile.user = @user

    if @coach_profile.save
      redirect_to coach_coach_profile_path(@coach_profile)
    else
      render :new
    end

    authorize @coach_profile
  end

  private

  def coach_profile_params
    params.require(:coach_profile).permit(:coach_start_date, :description, :sport, :user, :sport_id, :user_id, photos: [])
  end
end
