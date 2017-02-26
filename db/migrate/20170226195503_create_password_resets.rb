# frozen_string_literal: true
class CreatePasswordResets < ActiveRecord::Migration[5.0]
  def change
    create_table :password_resets, id: false do |t|
      t.uuid        :id, null: false, index: { unique: true }, primary_key: true, default: 'gen_random_uuid()'
      t.belongs_to  :user, index: true
      t.foreign_key :users, on_delete: :cascade
      t.string      :status, null: false, index: true, default: 'pending'
      t.index       [:user_id, :status], unique: true, where: "status = 'pending'"
      t.string      :email, null: false
      t.inet        :ip
      t.inet        :remote_ip
      t.timestamps  null: false
    end
  end
end
