class Coupon < ApplicationRecord
  belongs_to :order, optional: true
  validates :key, :value, presence: true
end
