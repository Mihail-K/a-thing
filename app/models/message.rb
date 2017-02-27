# frozen_string_literal: true
# == Schema Information
#
# Table name: messages
#
#  id         :integer          not null, primary key
#  author_id  :integer          not null
#  body       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_messages_on_author_id  (author_id)
#

# frozen_string_literal: true
class Message < ApplicationRecord
  belongs_to :author, class_name: 'User'

  validates :body, presence: true, length: { maximum: 1000 }

  scope :before, -> (time) { where('messages.created_at < ?', time) if time.present? }
  scope :after,  -> (time) { where('messages.created_at > ?', time) if time.present? }
end
