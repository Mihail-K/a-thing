# frozen_string_literal: true
class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.belongs_to  :author, null: false, index: true
      t.foreign_key :users, column: :author_id, on_delete: :cascade
      t.string      :body, null: false
      t.timestamps  null: false
    end
  end
end
