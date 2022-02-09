class BookingController < ApplicationController
  def index()
    @bookings = current_user.bookings
  end

  def create()
    @booking = Booking.new
  end

  def show()
    @booking = Booking.find(params[:id])
  end

  def destroy()
    @booking = Booking.find(params[:id])
    @booking.destroy
  end
end
