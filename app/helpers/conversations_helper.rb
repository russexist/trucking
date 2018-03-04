# frozen_string_literal: true

module ConversationsHelper
  def msg_recipient(conversation)
    conversation.recipients.reject { |recip| recip.eql?(current_user) }.first
  end
end
