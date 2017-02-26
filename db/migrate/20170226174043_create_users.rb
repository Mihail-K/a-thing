# frozen_string_literal: true
class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :email, null: false, index: { unique: true }
      t.string :display_name, null: false, index: { unique: true }
      t.string :password_digest
      t.string :first_name
      t.string :last_name

      t.timestamps null: false
    end
  end
end
