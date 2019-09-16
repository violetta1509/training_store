class AddVerifiedToReview < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :verified, :boolean, defauls: false
  end
end
