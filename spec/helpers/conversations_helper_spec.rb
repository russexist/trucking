# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ConversationsHelper, type: :helper do
  let!(:user) { create(:rand_user) }
  let!(:fake_user) { create(:rand_user) }

  before { user.send_message(fake_user, 'Hi', 'subject') }

  describe '.recipient' do
    it 'finds conversations recipient' do
      recipient = user.mailbox.conversations.first.recipients.reject { |u| u == user }.first
      expect(recipient).to eq(fake_user)
    end
  end
end
