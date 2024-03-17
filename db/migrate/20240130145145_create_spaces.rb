# frozen_string_literal: true

class CreateSpaces < ActiveRecord::Migration[7.0]
  def change
    create_table :spaces do |t|
      t.string :description, null: false
      t.string :software, null: false, default: 'none'
      t.jsonb :software_api_details, default: {}, null: false
      t.references :owner, index: true, foreign_key: { to_table: :users }, null: false
      t.boolean :public, null: false, default: false
      t.string :extra_units, array: true, default: []

      t.timestamps
    end
  end
end
