class Review < ApplicationRecord
  include AASM

  enum status: {
    unapproved: 0,
    approved: 1
  }

  aasm :status, column: :status, enum: true do
    state :unapproved, initial: true
    state :approved

    event :to_approve do
      transitions from: :unapproved, to: :approved
    end
  end

  scope :unapproved, -> { where(status: 'unapproved') }
  scope :approved, -> { where(status: 'approved') }

end
