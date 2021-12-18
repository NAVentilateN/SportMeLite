class StripeCheckoutSessionService
  def call(event)
    order = Order.find_by(checkout_session_id: event.data.object.id)
    lesson = Lesson.find(order.lesson_id)
    lesson.student = current_user
    lesson.status = true
    lesson.save!
    order.update(state: 'paid')
  end
end
