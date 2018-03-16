# frozen_string_literal: true

class ConversationsController < ApplicationController
  # before_action :set_conversation, only: %i[show destroy]
  before_action :authenticate_user!

  def new
    @recipients = User.all - [current_user]
  end

  def create
    # recipient = User.find(params[:user_id])
    # receipt   = current_user.send_message(recipient, params[:body], recipient)
    # redirect_to conversation_path(receipt.conversation)

    recipients = User.where(id: conversation_params[:recipients])
    conversation = current_user.send_message(recipients, conversation_params[:body], recipients).conversation
    flash[:success] = 'You are was successfully sent!'
    redirect_to conversation_path(conversation)
  end

  # def index
  #   @conversations = current_user.mailbox.conversations
  # end

  def show
    @receipts = conversation.receipts_for(current_user).order(:created_at)
    conversation.mark_as_read(current_user)
  end

  def reply
    current_user.reply_to_conversation(conversation, message_params[:body])
    flash[:notice] = 'Your reply message was successfully sent!'
    redirect_to conversation_path(conversation)
  end

  # def destroy
  #   @conversation.mark_as_deleted(current_user)
  #   redirect_to conversations_path
  # end

  def trash
    conversation.move_to_trash(current_user)
    redirect_to mailbox_inbox_path
  end

  def untrash
    conversation.untrash(current_user)
    redirect_to mailbox_inbox_path
  end

  private

  # def set_conversation
  #   @conversation = current_user.mailbox.conversations.find(params[:id])
  # end

  def conversation_params
    params.require(:conversation).permit(:body, :subject, recipients:[])
  end

  def message_params
    params.require(:message).permit(:body, :subject)
  end
end
