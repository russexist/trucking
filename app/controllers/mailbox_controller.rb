# frozen_string_literal: true

class MailboxController < ApplicationController
  def inbox
    @inbox = mailbox.inbox
    @active = :inbox
  end

  def sentbox
    @sentbox = mailbox.sentbox
    @active = :sentbox
  end
end
