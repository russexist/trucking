# frozen_string_literal: true

module MailboxHelper
  def active_page(active_page)
    @active == active_page ? 'active' : ''
  end

  def unread_messages_count
    mailbox.inbox(unread: true).count(:id)
  end
end
