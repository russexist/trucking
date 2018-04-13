# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ConversationsHelper, type: :helper do
  let!(:user) do
    User.create(email: '1@1.com', first_name: 'Ruha',
                last_name: 'Oliinyk', password: '123123')
  end
  let!(:fake_user) do
    User.create(email: '2@1.com', first_name: 'Egor',
                last_name: 'Zawgor', password: '123123')
  end

  before { user.send_message(fake_user, 'Hi', 'subject') }

  describe '.recipient' do
    it 'finds conversations recipient' do
      recipient = user.mailbox.conversations.first.recipients.reject { |u| u == user }.first
      expect(recipient).to eq(fake_user)
    end
  end
end
