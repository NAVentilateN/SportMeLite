class OrdersController < ApplicationController
  def create
  lesson = Lesson.find(params[:lesson_id])
  order  = Order.create!(lesson: lesson, lesson_id: lesson.id, amount: lesson.price, state: 'pending', user: current_user)

  session = Stripe::Checkout::Session.create(
    payment_method_types: ['card'],
    line_items: [{
      name: lesson.id,
      # images: [lesson.photo_url],
      amount: lesson.price_cents,
      currency: 'sgd',
      quantity: 1
    }],
    success_url: order_url(order),
    cancel_url: order_url(order)
  )

  order.update(checkout_session_id: session.id)
  redirect_to new_order_payment_path(order)
  end

  def show
  @order = current_user.orders.find(params[:id])
  end
end
