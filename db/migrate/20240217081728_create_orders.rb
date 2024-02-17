# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.references :space, null: false, foreign_key: true

      t.timestamps
    end
  end
end
