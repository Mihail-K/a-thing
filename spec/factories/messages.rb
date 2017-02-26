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

FactoryGirl.define do
  factory :message do
    association :author, factory: :user, strategy: :build

    body { Faker::Hipster.paragraph }
  end
end
