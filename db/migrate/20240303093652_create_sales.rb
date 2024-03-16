# frozen_string_literal: true

class CreateSales < ActiveRecord::Migration[7.1]
  def change
    create_table :sales do |t|
      t.references :space, null: false, foreign_key: true
      t.jsonb :details, null: false

      t.string :raw_post, null: false, default: ''
      t.string :kind, null: false, default: ''
      t.string :status, null: false, default: 'pending'
      t.string :webhook_identifier, null: false, default: ''
      t.string :event, null: false, default: ''

      t.timestamps
    end
  end
end
