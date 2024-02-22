# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :description, null: false, default: ''
      t.decimal :price, null: false, default: 0
      t.references :space, null: false, foreign_key: true
      t.integer :sales_count, null: false, default: 0

      t.timestamps
    end
  end
end
