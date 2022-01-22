class OrdersController < ApplicationController
  def create
    lesson = Lesson.find(params[:lesson_id])
    order  = Order.create!(lesson: lesson, lesson_id: lesson.id, amount: lesson.price, state: 'pending', user: current_user)

    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        name: lesson.description,
        images: ['https://www.cs.csubak.edu/~rayala/2680_F19/proj1/images/location.jpg'],
        amount: lesson.price_cents,
        currency: 'sgd',
        quantity: 1
      }],
      success_url: order_url(order),
      cancel_url: order_url(order)
    )

    order.update(checkout_session_id: session.id)

    # temp insert for testing booking notifications, commented out as handled by stripe_checkout_session_service.rb
    # lesson.status = true
    # lesson.student = current_user
    # lesson.save!
    Notification.create(recipient: lesson.coach, sender: current_user, action: "New booking from", notifiable: lesson)
    redirect_to new_order_payment_path(order)
  end

  def show
    @order = current_user.orders.find(params[:id])
  end
end
