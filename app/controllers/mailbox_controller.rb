# frozen_string_literal: true

class MailboxController < ApplicationController
  before_action :authenticate_user!

  def inbox
    @inbox = mailbox.inbox
    @active = :inbox
  end

  def sentbox
    @sentbox = mailbox.sentbox
    @active = :sentbox
  end
end
