class Coach::LessonPolicy < ApplicationPolicy
  def index
    policy_scope(@lessons)
  end

  def show
    post = authorize Lesson.find(params[:id])
  end

  def show
    true
  end

  def new?
    create?
  end

  def create?
    true  # Anyone can create a lesson
  end

  def edit?
    update?
  end

  def update?
    record.coach == user # Only lesson coach can update it
  end

  def destroy?
    record.coach == user # Only lesson coach can destroy it
  end
end
