class Book < ApplicationRecord
  has_and_belongs_to_many :authors

  belongs_to :category
  has_many :order_items, dependent: :destroy
  has_many :reviews, dependent: :destroy

  scope :selection_by_order, -> (order_filter) { public_send(order_filter) }

  scope :created_at_desc, -> () { order('created_at DESC') }
  scope :popular_desc, -> () { order('sold DESC') }
  scope :price_asc, -> () { order('price ASC') }
  scope :price_desc, -> () { order('price DESC') }
  scope :title_asc, -> () { order('title ASC') }
  scope :title_desc, -> () { order('title DESC') }
  scope :best_sellers, -> () { order('sold DESC') }
end
