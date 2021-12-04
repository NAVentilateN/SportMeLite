class CoachProfilesController < ApplicationController
  def show
    @user = current_user
    @coach_profile = CoachProfile.find(params[:id])
  end

  def new
    @coach_profile = CoachProfile.new
    @user = current_user
  end

  def create
    @coach_profile = CoachProfile.new(coach_profile_params)
    @user = current_user
    @coach_profile.user = @user

    if @coach_profile.save
      redirect_to user_coach_profile_path(@user, @coach_profile)
    else
      render :new
    end
  end

  def edit
    @coach_profile = CoachProfile.find(params[:id])
    @user = current_user
    @exists = true
  end

  def update
    @coach_profile = CoachProfile.find(params[:id])
    @coach_profile.update(coach_profile_params)
    @user = current_user

    if @coach_profile.save
      redirect_to user_coach_profile_path(@user, @coach_profile)
    else
      render :new
    end
  end

  private

  def coach_profile_params
    params.require(:coach_profile).permit(:coach_start_date, :description, :sport, :user, :sport_id, :user_id, :photo)
  end
end
