# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_enum :status_list, %i[pending cancelled delivered]

    create_table :orders do |t|
      t.references :space, null: false, foreign_key: true
      t.references :supplier, null: false, foreign_key: true
      t.datetime :expected_at
      t.datetime :delivered_at
      t.enum :status, enum_type: :status_list, default: :pending, null: false

      t.timestamps
    end
  end
end
