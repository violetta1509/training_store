class CreateCoupons < ActiveRecord::Migration[5.2]
  def change
    create_table :coupons do |t|
      t.string :key
      t.integer :value, default: 1
      t.boolean :active, default: true
      t.references :order
      t.timestamps
    end
  end
end
