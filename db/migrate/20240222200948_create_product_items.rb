# frozen_string_literal: true

class CreateProductItems < ActiveRecord::Migration[7.1]
  def change
    create_table :product_items do |t|
      t.references :product, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.decimal :gross_quantity, null: false, default: 1
      t.decimal :net_quantity, null: false, default: 1
      t.decimal :quantity_ratio, null: false, default: 1

      t.timestamps
    end
  end
end
