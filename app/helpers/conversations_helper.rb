# frozen_string_literal: true

module ConversationsHelper
  def recipient(conversation)
    conversation.recipients.reject { |user| user == current_user }.first
  end

  def unread?(conversation)
    conversation.is_unread?(current_user) ? 'unread' : ''
  end
end
