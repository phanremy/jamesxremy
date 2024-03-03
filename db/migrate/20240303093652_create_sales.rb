# frozen_string_literal: true

class CreateSales < ActiveRecord::Migration[7.1]
  def change
    create_table :sales do |t|
      t.references :space, null: false, foreign_key: true
      t.jsonb :details

      t.timestamps
    end
  end
end
