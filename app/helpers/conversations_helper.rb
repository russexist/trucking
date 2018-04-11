# frozen_string_literal: true

module ConversationsHelper
  def recipient(conversation)
    recipients = conversation.recipients
    recipients.delete(conversation.originator)
    recipients.first
  end

  def unread?(conversation)
    conversation.is_unread?(current_user) ? 'unread' : ''
  end
end
