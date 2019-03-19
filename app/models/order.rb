require 'aasm'
class Order < ApplicationRecord
  include AASM

  belongs_to :user
  has_many :order_items, dependent: :destroy

  enum status: {
    in_progress: 0,
    in_queue: 1,
    shiped: 2,
    delivered: 3,
    canceled: 4
  }

  aasm :status, column: :status, enum: true do
    state :in_progress, initial: true
    state :in_queue
    state :shiped
    state :delivered
    state :canceled
  end
end
