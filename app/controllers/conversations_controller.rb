# frozen_string_literal: true

class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def new
    @recipients = User.all - [current_user]
  end

  def create
    recipients = User.where(id: conversation_params[:recipients])
    conversation = current_user.send_message(recipients, conversation_params[:body], recipients).conversation
    flash[:success] = 'You are was successfully sent!'
    redirect_to conversation_path(conversation)
  end

  def show
    @receipts = conversation.receipts_for(current_user).order(:created_at)
    conversation.mark_as_read(current_user)
  end

  def reply
    current_user.reply_to_conversation(conversation, message_params[:body])
    flash[:notice] = 'Your reply message was successfully sent!'
    redirect_to conversation_path(conversation)
  end

  def trash
    conversation.move_to_trash(current_user)
    redirect_to mailbox_inbox_path
  end

  def untrash
    conversation.untrash(current_user)
    redirect_to mailbox_inbox_path
  end

  private

  def conversation_params
    params.require(:conversation).permit(:body, :subject, recipients: [])
  end

  def message_params
    params.require(:message).permit(:body, :subject)
  end
end
