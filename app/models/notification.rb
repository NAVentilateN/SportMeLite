class Notification < ApplicationRecord
  belongs_to :recipient, class_name: 'User', inverse_of: :notifications_received
  belongs_to :sender, class_name: 'User', inverse_of: :notifications_sent
  belongs_to :notifiable, polymorphic: true
end
