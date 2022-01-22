class StripeCheckoutSessionService
  def call(event)
    order = Order.find_by(checkout_session_id: event.data.object.id)
    order.update(state: 'paid')
    lesson = Lesson.find(order.lesson_id)
    lesson.student = order.user
    lesson.status = true
    lesson.save!
    Notification.create(recipient: lesson.coach, sender: current_user, action: "Lesson ID: #{lesson.id} booked by", notifiable: lesson)
    
    # LessonMailer.lesson_confirmation(lesson).deliver_later
    # LessonMailer.lesson_booked(lesson).deliver_later
  end
end
