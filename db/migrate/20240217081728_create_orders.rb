# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.references :space, null: false, foreign_key: true
      t.references :supplier, null: false, foreign_key: true
      t.datetime :expected_date

      t.timestamps
    end
  end
end
