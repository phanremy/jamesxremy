# frozen_string_literal: true

class CreateLinks < ActiveRecord::Migration[7.0]
  def change
    create_table :links do |t|
      t.string :sku, null: false
      t.references :space, null: false, foreign_key: true
      t.references :owner, index: true, foreign_key: { to_table: :users }, null: false
      t.datetime :end_date, null: false

      t.timestamps
    end

    add_index :links, %i[space_id owner_id], unique: true
    add_index :links, :sku, unique: true
  end
end
