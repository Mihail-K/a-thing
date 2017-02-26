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

require 'rails_helper'

RSpec.describe Message, type: :model do
  subject { build(:message) }

  it 'has a valid factory' do
    should be_valid
  end

  it 'is invalid without an author' do
    subject.author = nil
    should be_invalid
  end

  it 'is invalid without a body' do
    subject.body = nil
    should be_invalid
  end

  it 'is invalid when the body is too long' do
    subject.body = Faker::Lorem.characters(1001)
    should be_invalid
  end
end
