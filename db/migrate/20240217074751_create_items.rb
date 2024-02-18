# frozen_string_literal: true

class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.string :description, null: false, default: ''
      t.string :reference, null: false, default: ''
      t.decimal :actual_quantity, null: false, default: 0
      t.decimal :expected_quantity, null: false, default: 0
      t.references :supplier, null: false, foreign_key: true
      t.references :space, null: false, foreign_key: true

      t.timestamps
    end
  end
end
