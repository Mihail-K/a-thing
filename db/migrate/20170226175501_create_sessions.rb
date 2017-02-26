# frozen_string_literal: true
class CreateSessions < ActiveRecord::Migration[5.0]
  def change
    create_table :sessions, id: false do |t|
      t.uuid        :id, null: false, index: { unique: true }, primary_key: true, default: 'uuid_generate_v4()'
      t.belongs_to  :user, null: false, index: true
      t.foreign_key :users, on_delete: :cascade
      t.inet        :ip
      t.inet        :remote_ip
      t.boolean     :active, null: false, index: true, default: true
      t.timestamp   :expires_at, null: false
      t.timestamps  null: false
    end
  end
end
