# frozen_string_literal: true

class CreateSuppliers < ActiveRecord::Migration[7.1]
  def change
    create_table :suppliers do |t|
      t.string :name, null: false, default: ''
      t.references :space, null: false, foreign_key: true
      t.integer :expected_day, null: false, default: 0
      t.integer :expected_week, null: false, default: 0
      t.integer :expected_month, null: false, default: 0

      t.timestamps
    end
  end
end
